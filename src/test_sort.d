module test_sort;
/**
 *
 */
import cl;
import common;

import std.stdio		        : writefln;
import std.datetime.stopwatch	: StopWatch;
import std.random               : Random, uniform01, unpredictableSeed;
import std.algorithm            : sort;
import std.format               : format;
import std.algorithm.iteration  : sum;

void main() {
	auto app = new Sort;
	app.setup();
	app.run();
	app.destroy();
}
class Sort {
    bool profiling = true;
    bool debugging = false;
    bool ascending = true;
    uint N         = 1048576;//4096;//512;//512;//1024;
    Random rng;
    OpenCL cl;
    CLPlatform platform;
    CLContext context;
    CLDevice device;
    CLCommandQueue queue;
    CLMemMapping!float inMem;
    CLMemMapping!float outMem;
    float[] numbers;

    this() {
        this.cl       = new OpenCL();
        this.platform = cl.getPlatform(CL_DEVICE_TYPE_GPU, CLVersion.CL20);
        this.context  = platform.createGPUContext(null);
        this.device   = context.getDevices[0];
        this.queue    = context.createQueue(device, profiling);
        this.numbers  = new float[N];
        rng.seed(unpredictableSeed);
        //rng.seed(1);
    }
    void destroy() {
        cl.destroy();
    }
    void setup() {
        inMem  = new CLMemMapping!float(context, queue, MMFlags.GPU_READ_WRITE, N);
        outMem = new CLMemMapping!float(context, queue, MMFlags.GPU_READ_WRITE, N);

        for(auto i=0; i<numbers.length; i++) {
            numbers[i] = cast(int)(uniform01(rng)*1000);
        }
        float* ptr = inMem.mapForHostWrite(true);
        for(auto i=0; i<N; i++) {
            ptr[i] = numbers[i];
        }
        inMem.unmap(ptr);
    }
    bool verify(CLMemMapping!float mem) {
        writefln("original[0..20] = %s", numbers[0..20]);

        StopWatch watch;
        watch.start();
        if(ascending) {
            writefln("Ascending");
            sort!((float a, float b) => a < b)(numbers);
        } else {
            writefln("Descending");
            sort!((float a, float b) => a > b)(numbers);
        }
        watch.stop();
        writefln("CPU sort took %s ms", watch.peek().total!"nsecs"/1000000.0);
        writefln("sorted  [0..512] = %s", numbers[0..512]);

        bool ok = true;
        auto ptr = mem.mapForHostRead(true);
        mem.unmap(ptr);

        writefln("opencl  [0..512] = %s", ptr[0..512]);

        foreach(i,n; numbers) {
            if(n!=ptr[i]) ok = false;
        }
        return ok;
    }
    void run() {

        enum { SORT, SORT_AND_MERGE, SORT2 }
        const type = SORT_AND_MERGE;

        debugging = false;
        ascending = true;

        int WORK_GROUP_SIZE = cast(int)device.maxWorkGroupSize;

        expect(N % WORK_GROUP_SIZE==0);
        expect(isPowerOf2(N));

        auto program = context.getProgram(
            "kernels/kernel_sort.c",
            [
             debugging ? "-D DEBUG" : "",
             "-D WORK_GROUP_SIZE=%s".format(WORK_GROUP_SIZE),
             "-D ASCENDING=%s".format(ascending),
             "-I kernels/ ",
             "-I C:/pvmoore/_assets/kernels/ ",
             "-cl-std=CL2.0 ",
             //"-cl-uniform-work-group-size "
            ]
        );
        if(!program.compiled) {
            return;
        }

        auto sortKernel = program.getKernel("bitonicSortLocal");
        sortKernel.setArg!CLBuffer(0, inMem.buffer);

        auto mergeKernel = program.getKernel("merge");
        mergeKernel.setArg!CLBuffer(0, inMem.buffer);
        mergeKernel.setArg!CLBuffer(1, outMem.buffer);

        auto sort2Kernel = program.getKernel("Sort2");
        sort2Kernel.setArg!CLBuffer(0, inMem.buffer);
        sort2Kernel.setArg!CLBuffer(1, outMem.buffer);

        writefln("maxWorkGroupSize .. %s", sortKernel.getMaxWorkGroupSize(device));
        writefln("localMemSize ...... %s", sortKernel.getLocalMemSize(device));
        writefln("privateMemSize .... %s", sortKernel.getPrivateMemSize(device));
        writefln("getPreferredWorkGroupSizeMultiple .. %s", sortKernel.getPreferredWorkGroupSizeMultiple(device));

        StopWatch watch;
        watch.start();
        ulong sortKernelTime;
        ulong[] mergeKernelTimes;
        cl_event kernelEvent;

        //---------------------------------------------
        // Sort into N/WGSIZE chunks
        //---------------------------------------------
        static if(type==SORT || type==SORT_AND_MERGE) {
            queue.enqueueKernel(
                sortKernel,
                [N],                // global sizes
                [WORK_GROUP_SIZE],  // local sizes
                null,               // wait list
                &kernelEvent
            );
            queue.flush();

            kernelEvent.await();
            sortKernelTime = kernelEvent.getRunTime();
            kernelEvent.release();
        }
        // 256 = 93000 ps

        static if(type==SORT_AND_MERGE) {
            uint chunkSize = WORK_GROUP_SIZE;

            cl_event copyEvent;

            while(chunkSize<N) {
                //writefln("merging using chunkSize=%s", chunkSize);

                mergeKernel.setArg!uint(2, chunkSize);

                queue.enqueueKernel(
                    mergeKernel,
                    [N],                // global sizes
                    null,               // local sizes (don't care)
                    null,               // wait list
                    null//&kernelEvent
                );

                chunkSize <<= 1;

                if(chunkSize<N) {
                    queue.enqueueCopyBuffer(
                        outMem.buffer,
                        inMem.buffer,
                        null,//[kernelEvent],
                        null//&copyEvent
                    );
                }
                queue.flush();

                //if(copyEvent.getReferenceCount>0) {
                //    copyEvent.await();
                //} else {
                //    kernelEvent.await();
                //}
                //mergeKernelTimes ~= kernelEvent.getRunTime();
                //kernelEvent.release();
                //
                //if(copyEvent.getReferenceCount>0) {
                //    copyEvent.release();
                //}
            }
        }
        // 1M floats = 6.8928 ms
        //---------------------------------------------
        // Sort2
        //---------------------------------------------
        static if(type==SORT2) {
            queue.enqueueKernel(
                sort2Kernel,
                [N/2],              // global sizes
                [WORK_GROUP_SIZE],  // local sizes
                null,               // wait list
                &kernelEvent
            );
            queue.flush();

            kernelEvent.await();
            mergeKernelTimes ~= kernelEvent.getRunTime();
            kernelEvent.release();
        }
        // 512 = 89285 ps

        queue.finish();
        watch.stop();

        writefln("Sort time ........... %s ms (%s per second)",
            sortKernelTime/1000000.0,
            1_000_000_000.0/sortKernelTime);
        foreach(i, m; mergeKernelTimes) {
        writefln("Merge time [%s] ...... %s ms (%s per second)",
            i,
            m/1000000.0,
            1_000_000_000.0/m);
        }
        writefln("Total time .......... %s ms (%s per second)",
            (sortKernelTime+mergeKernelTimes.sum())/1000000.0,
            1_000_000_000.0/(sortKernelTime+mergeKernelTimes.sum()));

        bool ok = verify(
            type==SORT ? inMem : outMem
        );
        writefln("%s", ok ? "OK" : "FAIL");

        writefln("GPU sort took %s ms", watch.peek().total!"nsecs"/1000000.0);

        // selection: 0.03728 ms (26824 ps) for 256 (single workgroup)
        // bitonic:   0.01136 ms (88028 ps) for 256 (single workgroup)

        //auto ptr = inMem.mapForHostRead(true);
        //inMem.unmap(ptr);
        //writefln("[0..256]   = %s", ptr[0..256]);
        //writefln("[256..512] = %s", ptr[256..512]);
    }
}
