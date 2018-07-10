module test_enqueue;
/**
 *
 */
import cl;
import common;

import std.stdio		        : writefln;
import std.datetime.stopwatch	: StopWatch;

void main() {
	auto cl = new OpenCL();
	scope(exit) cl.destroy();

	CLPlatform platform = cl.getPlatform(CL_DEVICE_TYPE_GPU, CLVersion.CL20);
	CLContext context   = platform.createGPUContext(null);

    run(context, false);
}
void run(CLContext context, bool debugEnabled=false) {
    writefln("Running enqueue kernel test...");

    CLDevice device = context.getDevices[0];
    writefln("Using device %s version %s", device.name, device.deviceVer);

    auto queue = context.createQueue(device, true);

    auto N       = 10;
    auto indata  = new float[N];
    foreach(i; 0..N) {
        indata[i] = i;
    }

    cl_event kernelEvent;

    auto inBuf = context.createBuffer(
        CL_MEM_READ_ONLY | CL_MEM_HOST_WRITE_ONLY, float.sizeof*N);
    auto outBuf = context.createBuffer(
        CL_MEM_WRITE_ONLY | CL_MEM_HOST_READ_ONLY, float.sizeof*N);

    queue.enqueueWriteBuffer(
        inBuf,      // dest buffer
        indata.ptr // src data
    );

    auto program = context.getProgram(
        "kernels/kernel_enqueue.c",
        [
        debugEnabled ? "-D DEBUG" : "",
        "-I kernels/ ",
        "-I C:/pvmoore/_assets/kernels/ ",
        "-cl-std=CL2.0 ",
        "-g " // debugging info about enqueued kernels
        ]
    );
    if(!program.compiled) {
        return;
    }
    auto kernel = program.getKernel("compute");
    kernel.setArg!CLBuffer(0, inBuf);
    kernel.setArg!CLBuffer(1, outBuf);

    // create the device queue otherwise you will get
    // an out of resources error
    context.createQueueOnDevice(device);

    queue.enqueueKernel(
        kernel,
        [N],    // global sizes
        null,   // local sizes
        null,   // wait list
        &kernelEvent);

    auto outputBuf = new float[N];
    queue.enqueueReadBuffer(outBuf, outputBuf.ptr);

    queue.finish();

    auto kernelTime = kernelEvent.getRunTime();
    kernelEvent.release();

    writefln("output[0]=%s", outputBuf[0]);
    writefln("output[1]=%s", outputBuf[1]);

    writefln("Kernel took %s ms", kernelTime/1_000_000.0);

    writefln("Finished");
}
