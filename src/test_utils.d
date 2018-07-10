module test_utils;
/**
 *  Test CLMemMapping.
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

    testCLMemMapping(context, false);
}
void testCLMemMapping(CLContext context, bool debugEnabled=false) {
    writefln("Running utils test...");

    auto dev   = context.getDevices[0];
    auto queue = context.createQueue(dev, true);

    auto N = 1*1024*1024;
    auto inMem  = new CLMemMapping!ubyte(context, queue, MMFlags.GPU_READ, N);
    auto outMem = new CLMemMapping!ubyte(context, queue, MMFlags.GPU_WRITE, N);

    // Pre-fill the data
    ubyte* ptr = inMem.ptr;
    for(auto i=0; i<N; i++) {
        ptr[i] = cast(ubyte)i;
    }

    auto program = context.getProgram(
        "kernels/kernel_copy1d.c",
        [
         debugEnabled ? "-D DEBUG" : "",
         "-I kernels/ ",
         "-I C:/pvmoore/_assets/kernels/ ",
         "-cl-std=CL2.0 "
        ]
    );
    if(!program.compiled) {
        return;
    }

    auto kernel = program.getKernel("copy1D");
    kernel.setArg!CLBuffer(0, inMem.buffer);
    kernel.setArg!CLBuffer(1, outMem.buffer);

    // copy data to GPU
    auto ip = inMem.mapForHostWrite(false);
    inMem.unmap(ip);

    // Run the kernel
    queue.enqueueKernel(
        kernel,
        [N]
    );
    queue.finish();

    // Copy data from GPU
    auto op = outMem.mapForHostRead(true);
    outMem.unmap(op);

    auto op2 = outMem.ptr;
    writefln("[0..10] = %s", op2[0..10]);
}


