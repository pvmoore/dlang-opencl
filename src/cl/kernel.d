module cl.kernel;

import cl.all;

final class CLKernel {
	cl_kernel id;
	string name;

	this(CLProgram prog, string name) {
		cl_int errNum;
		id = clCreateKernel(prog.id, name.toStringz, &errNum);
		checkError(errNum, __FILE__, __LINE__);
	}
	void destroy() {
        if(id) clReleaseKernel(id); id = null;
	}
	
	//void setArg(uint index, Buffer buf) {
	//	cl_int errNum = clSetKernelArg(id, index, cl_mem.sizeof, &buf.id);
	//	checkError(errNum, __FILE__, __LINE__);
	//}
	//void setArg(uint index, uint value) {
    //    cl_int errNum = clSetKernelArg(id, index, uint.sizeof, &value);
    //    checkError(errNum, __FILE__, __LINE__);
    //}
    //void setArg(uint index, float value) {
    //    cl_int errNum = clSetKernelArg(id, index, float.sizeof, &value);
    //    checkError(errNum, __FILE__, __LINE__);
    //}
    void setArg(T)(uint index, T value) {
        //static if(is(T==CLBuffer) || is(T==Image)) {
        static if(is(T:MemObject)) {
            setArg(index, cl_mem.sizeof, &value.id);
        } else {
            setArg(index, T.sizeof, &value);
        }
    }
	void setArg(uint index, size_t ptrSize, void* value) {
		cl_int errNum = clSetKernelArg(id, index, ptrSize, value);
		checkError(errNum, __FILE__, __LINE__);
	}

    ulong[2] getRowMajorWorkGroupSize2d(CLDevice dev) {
        return [
            getPreferredWorkGroupSizeMultiple(dev),
            1
        ];
    }
    ulong[2] getColumnMajorWorkGroupSize2d(CLDevice dev) {
        return [
            1,
            getPreferredWorkGroupSizeMultiple(dev)
        ];
    }
	ulong[2] getSquareWorkGroupSize2d(CLDevice dev) {
        ulong n = getPreferredWorkGroupSizeMultiple(dev);

        // AMD is always 64
        if(n==64) return [8,8];

        // NVidia and Intel seem to like 32
        if(n==32) return [8,4];

        // perfect square
        import std.math : sqrt;
        ulong sq = cast(ulong)sqrt(cast(float)n);
        if(sq*sq==n) return [sq,sq];

        // find the innermost rectangle
        auto factors  = factorsOf(n);
        auto start    = 0;
        auto end      = factors.length-1;
        ulong[2] size = [n,1];
        while(start<end) {
            size[0] = factors[start];
            size[1] = factors[end];
            start++;
            end--;
        }
        return size;
	}

    ulong getMaxWorkGroupSize(CLDevice dev) {
        return getUlongWorkGroupInfo(dev.id, CL_KERNEL_WORK_GROUP_SIZE);
    }
    ulong getLocalMemSize(CLDevice dev) {
        return getUlongWorkGroupInfo(dev.id, CL_KERNEL_LOCAL_MEM_SIZE);
    }
    ulong getPrivateMemSize(CLDevice dev) {
        return getUlongWorkGroupInfo(dev.id, CL_KERNEL_PRIVATE_MEM_SIZE);
    }
    ulong getPreferredWorkGroupSizeMultiple(CLDevice dev) {
        return getUlongWorkGroupInfo(dev.id, CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE);
    }
private:
    /**
     * https://www.khronos.org/registry/OpenCL/sdk/1.2/docs/man/xhtml/clGetKernelWorkGroupInfo.html
     */
    ulong getUlongWorkGroupInfo(
        cl_device_id devId,
        cl_kernel_work_group_info param)
    {
        ulong value;
        getWorkGroupInfo(devId, param, &value, ulong.sizeof);
        return value;
    }
    void getWorkGroupInfo(
        cl_device_id devId,
        cl_kernel_work_group_info param,
        void* paramPtr, ulong paramSize)
    {
        checkError(clGetKernelWorkGroupInfo(
            id,
            devId,
            param,
            paramSize,
            paramPtr,
            null
       ), __FILE__, __LINE__);
    }
}