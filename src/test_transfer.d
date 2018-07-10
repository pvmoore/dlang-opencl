module test_transfer;
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
    writefln("Running transfer speed test...");

    auto dev   = context.getDevices[0];
    auto queue = context.createQueue(dev, true);

    uint N      = 100*1024*1024;
    auto inputA = new ubyte[N];
    auto output = new ubyte[N];

    for(auto i=0; i<N; i++) {
        inputA[i] = cast(ubyte)i;
    }

    auto inputBuf1 = context.createBuffer(
        CL_MEM_READ_ONLY |
        //CL_MEM_ALLOC_HOST_PTR,
        CL_MEM_USE_HOST_PTR,
        ubyte.sizeof*N,
        inputA.ptr
    );
    auto outputBuf = context.createBuffer(
        CL_MEM_WRITE_ONLY | CL_MEM_HOST_READ_ONLY,
        ubyte.sizeof*N
    );

//    ubyte* pp = cast(ubyte*)queue.enqueueMapBuffer(
//        inputBuf1,
//        0,
//        1,
//        CL_MAP_READ,
//        null,
//        true
//    );
//    queue.enqueueUnmapMemObject(inputBuf1, pp);
//    pp[0..N] = inputA[0..N];

    auto program = context.getProgram(
        "kernels/kernel_Transfer.c",
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

    auto kernel = program.getKernel("Transfer");
    kernel.setArg!CLBuffer(0, inputBuf1);
    kernel.setArg!CLBuffer(1, outputBuf);
    kernel.setArg!uint(2, N);

    writefln("Running..."); flushConsole();
    StopWatch watch; watch.start();

    writefln("Writing 10 * 100 MB buffers from host to device");
    int option  = 2;
    const count = 10;

    for(auto i=0; i<count; i++) {

        if(option==0) {
            // write buffer
            queue.enqueueWriteBuffer(
                inputBuf1,
                inputA.ptr
            );
        } else if(option==1) {
            // write partial buffer
            queue.enqueueWriteBufferRect(
                inputBuf1,
                0,          // offset
                inputA.ptr,
                N
            );
        } else if(option==2) {
            // map
            // copy data from host ptr to the device
            ubyte* ptr1 = cast(ubyte*)queue.enqueueMapBuffer(
                inputBuf1,
                0,
                N,
                CL_MAP_READ,
                null,
                false
            );
            // write more data to ptr1 here if required
            // ...
            // Tell GPU to take ownership of the data
            queue.enqueueUnmapMemObject(inputBuf1, ptr1);
        }

        queue.enqueueKernel(
            kernel,
            [10]
        );
        //queue.flush();
    }
    queue.finish();
    watch.stop();

    queue.enqueueReadBuffer(outputBuf, output.ptr, null, true);

    writefln("Watch time ... %.2f millis", watch.peek().total!"nsecs"/1000000.0);

    // 10*100m ubytes (buffer) = 110 ms
    //             buffer rect = 110 ms
    //             map buffer  = 10 ms

    writefln("%s", output[0..10]);
}

