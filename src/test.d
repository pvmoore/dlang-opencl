module test;

import std.stdio		        : writefln;
import std.datetime.stopwatch	: StopWatch;
import std.algorithm.iteration  : each;
import std.array                : array, join;

import cl;
import common;


float toMillis(ulong nanos) {
    return nanos/1_000_000.0;
}

void main() {
	auto cl = new OpenCL();
	scope(exit) cl.destroy();

	CLPlatform platform  = cl.getPlatform(CL_DEVICE_TYPE_GPU, CLVersion.CL12);
	writefln("%s", platform);
	CLContext gpuContext = platform.createGPUContext(null);
	CLContext cpuContext = platform.createCPUContext(null);

    CLDevice[] devices = platform.getDevices();
    writefln("Platform[0] has %s devices:", devices.length);
    foreach(d; devices) {
        writefln("%s -> %s", d.name, d.deviceVer);
    }

    CLDevice[] gpuDev = platform.getDevices(CL_DEVICE_TYPE_GPU);
	writefln("GPU Devices (%s):\n%s", gpuDev.length, gpuDev);

    CLDevice[] cpuDevices = platform.getDevices(CL_DEVICE_TYPE_CPU);
    writefln("CPU Devices (%s):\n%s", cpuDevices.length, cpuDevices);

    // CPU
    //simple1DKernel(cpuContext, false);

    // GPU
    simple1DKernel(gpuContext, false);

    writefln("");
    writefln("[Previous AMD driver version   : 2527.8 (19-01-2018)]");
    writefln("[Previous Intel driver version : 5.2.0.10094]");
}

void simple1DKernel(CLContext ctx, bool debugEnabled=false) {
    CLDevice dev = ctx.getDevices[0];

    uint N = 10*1024*1024;
    float[] inputA = new float[N];
    float[] inputB = new float[N];
    ubyte[] inputC = new ubyte[N];
    float[] output = new float[N];

    for(uint i=0; i<N; i++) {
        inputA[i] = 3;
        inputB[i] = 2;
        inputC[i] = i&255;
        output[i] = 0;
    }

    auto inputBuf1 = ctx.createBuffer(CL_MEM_READ_ONLY, float.sizeof*N);
    auto inputBuf2 = ctx.createBuffer(CL_MEM_READ_ONLY, float.sizeof*N);
    auto inputBuf3 = ctx.createBuffer(CL_MEM_READ_ONLY, N);
    auto outputBuf = ctx.createBuffer(CL_MEM_WRITE_ONLY, float.sizeof*N);

    
    auto program = ctx.getProgram(
        "kernels/kernel_simple1d.c",
        ["-D DOSOMETHING",
         "-D PETER=2",
         debugEnabled ? "-D DEBUG" : ""
         ],
         true
    );
    if(!program.compiled) {
        return;
    }

    auto kernel = program.getKernel("Add");
    kernel.setArg!CLBuffer(0, inputBuf1);
    kernel.setArg!CLBuffer(1, inputBuf2);
    kernel.setArg!CLBuffer(2, inputBuf3);
    kernel.setArg!CLBuffer(3, outputBuf);
    kernel.setArg!uint(4, N);


    writefln("getLocalMemSize %s", kernel.getLocalMemSize(dev));
    writefln("getPrivateMemSize = %s", kernel.getPrivateMemSize(dev));

    writefln("getMaxWorkGroupSize %s", kernel.getMaxWorkGroupSize(dev));
    writefln("getPreferredWorkGroupSizeMultiple = %s", kernel.getPreferredWorkGroupSizeMultiple(dev));
    writefln("getSquareWorkGroupSize = %s", kernel.getSquareWorkGroupSize2d(dev));
    writefln("getRowMajorWorkGroupSize2d = %s", kernel.getRowMajorWorkGroupSize2d(dev));
    writefln("getColumnMajorWorkGroupSize2d = %s", kernel.getColumnMajorWorkGroupSize2d(dev));

    auto queue = ctx.createQueue(dev, true);

    cl_event event1,event2,event3,event4;
    cl_event kernelEvent;
    ulong totalMemTransferTime;
    ulong kernelExecuteTime;
    StopWatch watch;
    watch.start();
    queue.enqueueWriteBuffer(inputBuf1, inputA.ptr, null, false, &event1);
    queue.enqueueWriteBuffer(inputBuf2, inputB.ptr, null, false, &event2);
    queue.enqueueWriteBuffer(inputBuf3, inputC.ptr, null, false, &event3);

    // execute the kernel
    queue.enqueueKernel(
        kernel,
        [N],    // global sizes
        null,   // local sizes
        null,   // wait list
        &kernelEvent);

    queue.enqueueReadBuffer(outputBuf, output.ptr, null, false, &event4);

    writefln("############### Kernel printf output:");
    flushConsole();

    queue.finish();
    watch.stop();
    //if(!debugEnabled) {
        totalMemTransferTime += event1.getRunTime();
        totalMemTransferTime += event2.getRunTime();
        totalMemTransferTime += event3.getRunTime();
        totalMemTransferTime += event4.getRunTime();
        kernelExecuteTime = kernelEvent.getRunTime();
    //}
    writefln("###############");
    writefln("kernelEvent status = %s", kernelEvent.getStatus);
    writefln("event ref count = %s", kernelEvent.getReferenceCount);

    [event1, event2, event3, event4, kernelEvent].each!(it=>it.release());

    writefln("Total mem transfer time .. %s millis", totalMemTransferTime.toMillis);
    writefln("Kernel execute time ...... %s millis", kernelExecuteTime.toMillis);

    writefln("\nTotal time %s millis (N=%s)", watch.millis, N);

    // 1.19632  1.1968

    static if(false) {
    for(uint i=0; i<N; i++) {
        if(output[i] != 1.5f) {
            writefln("Error!! Output is %s at index %s", output[i], i);
            break;
        }
    }
    }
}
