module test_image_read;
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
    writefln("Running image read test...");

    auto dev   = context.getDevices[0];
    auto queue = context.createQueue(dev, true);

    uint width  = 10_000;
    uint height = 10_000;
    uint N      = width*height;

    auto inputA = new ubyte[N];
    auto output = new ubyte[N];

    for(auto i=0; i<N; i++) {
        inputA[i] = 1;
    }

    auto inputBuf1 = context.createBuffer(
        CL_MEM_READ_ONLY,
        ubyte.sizeof*N
    );
    auto outputBuf = context.createBuffer(
        CL_MEM_WRITE_ONLY,
        ubyte.sizeof*N
    );
    auto image2d = context.createImage(
        CL_MEM_READ_ONLY,
        cl_image_format(CL_R, CL_UNSIGNED_INT8),
        cl_image_desc(
            CL_MEM_OBJECT_IMAGE2D,  // type
            width,                  // width
            height,                 // height
            1,                      // depth
            1,                      // array size
            0,                      // row pitch
            0,                      // slice pitch
            0,                      // mipmap level
            0,                      // num samples
            null                    // buffer
        ),
        null
    );

    auto program = context.getProgram(
        "kernels/kernel_RandomImageRead.c",
        [
         debugEnabled ? "-D DEBUG" : ""
        ]
    );
    if(!program.compiled) {
        return;
    }

    auto kernel = program.getKernel("RandomImageRead");
    kernel.setArg!CLBuffer(0, inputBuf1);
    kernel.setArg!Image(1, image2d);
    kernel.setArg!CLBuffer(2, outputBuf);
    kernel.setArg!uint(3, N);

    queue.enqueueWriteImage(image2d, inputA.ptr);
    queue.enqueueWriteBuffer(inputBuf1, inputA.ptr, null, false);

    writefln("Running kernels..."); flushConsole();
    ulong kernelTime;
    uint count = 100;
    for(auto i=0; i<count; i++) {
        cl_event kernelEvent;
        queue.enqueueKernel(
            kernel,
            [N],    // global sizes
            null,   // local sizes
            null,   // wait list
            &kernelEvent
        );
        queue.finish();
        kernelTime += kernelEvent.getRunTime;
        kernelEvent.release();
    }

    queue.enqueueReadBuffer(outputBuf, output.ptr, null, true);

    writefln("N = %s", N);
    writefln("Kernel execute time ... %s millis", (kernelTime/1_000_000.0)/count);

    // 100m random access ubytes (buffer) = 6.3
    //                           (image)  = 7.8 (int2 coords)
    //                                    = 8.7 (float2 coords)

    bool CHECK = false;
    if(CHECK) {
        for(auto i=0; i<N; i++) {
            if(output[i]!=10) { writefln("!!output in incorrect!!"); break;}
        }
    }
    writefln("%s", output[0..100]);
}

