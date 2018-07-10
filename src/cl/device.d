module cl.device;

import cl.all;

final class CLDevice {
	cl_device_id id;
	string vendor;
	cl_device_type type = CL_DEVICE_TYPE_DEFAULT;
	cl_uint maxComputeUnits;
	cl_uint maxWorkItemDims;
	size_t maxWorkGroupSize;
	size_t[] maxWorkItemSizes;
	cl_uint maxClockFreq;
	cl_uint addressBits;
	cl_ulong maxMemAllocSize;
	cl_ulong globalMemSize;
	cl_ulong localMemSize;
	cl_ulong maxConstantBufferSize;
	cl_bool available;
	cl_bool compilerAvailable;
	cl_bool littleEndian;
	cl_bool errorCorrection;
	cl_uint cacheLineSize;
	cl_uint nativeVectorWidthFloat;
	cl_uint preferredVectorWidthFloat;
	string extensions;
	string name;
	string deviceVer;
	string driverVer;
	cl_command_queue_properties queueProperties;
	cl_device_exec_capabilities execCaps;
	size_t timerResolution;
	cl_uint maxConstantArgs;
	cl_device_fp_config fpConfig;
	string builtInKernels;
	cl_bool imageSupport;
	size_t imageMaxWidth;
	size_t imageMaxHeight;
	cl_bool linkerAvailable;
	string cVersion;

    // this seems to work on AMD and Intel
	bool isVersion120() {
        return deviceVer.indexOf("OpenCL 1.2")==0;
	}
	bool isVersion200() {
        return deviceVer.indexOf("OpenCL 2.0")==0;
    }

	this(cl_device_id id) {
		this.id = id;
		
		char[1024] buf;
		checkError(clGetDeviceInfo(id, CL_DEVICE_VENDOR, buf.sizeof, &buf, null), __FILE__, __LINE__);
		vendor ~= buf[0..indexOf(buf, 0)];
		
		checkError(clGetDeviceInfo(id, CL_DEVICE_TYPE, type.sizeof, &type, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_COMPUTE_UNITS, maxComputeUnits.sizeof, &maxComputeUnits, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, maxWorkItemDims.sizeof, &maxWorkItemDims, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_WORK_GROUP_SIZE, maxWorkGroupSize.sizeof, &maxWorkGroupSize, null), __FILE__, __LINE__);

		maxWorkItemSizes = new size_t[maxWorkItemDims];
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_WORK_ITEM_SIZES, maxWorkItemDims*size_t.sizeof, maxWorkItemSizes.ptr, null), __FILE__, __LINE__);
		
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_CLOCK_FREQUENCY, maxClockFreq.sizeof, &maxClockFreq, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_ADDRESS_BITS, addressBits.sizeof, &addressBits, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_MEM_ALLOC_SIZE, maxMemAllocSize.sizeof, &maxMemAllocSize, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_GLOBAL_MEM_SIZE, globalMemSize.sizeof, &globalMemSize, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_LOCAL_MEM_SIZE, localMemSize.sizeof, &localMemSize, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, maxConstantBufferSize.sizeof, &maxConstantBufferSize, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_AVAILABLE, available.sizeof, &available, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_COMPILER_AVAILABLE, compilerAvailable.sizeof, &compilerAvailable, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_ENDIAN_LITTLE, littleEndian.sizeof, &littleEndian, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_ERROR_CORRECTION_SUPPORT, errorCorrection.sizeof, &errorCorrection, null), __FILE__, __LINE__);
		
		checkError(clGetDeviceInfo(id, CL_DEVICE_EXTENSIONS, buf.sizeof, &buf, null), __FILE__, __LINE__);
		extensions ~= buf[0..indexOf(buf, 0)];
		checkError(clGetDeviceInfo(id, CL_DEVICE_NAME, buf.sizeof, &buf, null), __FILE__, __LINE__);
		name ~= buf[0..indexOf(buf, 0)];
		checkError(clGetDeviceInfo(id, CL_DEVICE_VERSION, buf.sizeof, &buf, null), __FILE__, __LINE__);
		deviceVer ~= buf[0..indexOf(buf, 0)];
		checkError(clGetDeviceInfo(id, CL_DRIVER_VERSION, buf.sizeof, &buf, null), __FILE__, __LINE__);
		driverVer ~= buf[0..indexOf(buf, 0)];
		
		checkError(clGetDeviceInfo(id, CL_DEVICE_QUEUE_PROPERTIES, queueProperties.sizeof, &queueProperties, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_EXECUTION_CAPABILITIES, execCaps.sizeof, &execCaps, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_PROFILING_TIMER_RESOLUTION, timerResolution.sizeof, &timerResolution, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_MAX_CONSTANT_ARGS, maxConstantArgs.sizeof, &maxConstantArgs, null), __FILE__, __LINE__);
		checkError(clGetDeviceInfo(id, CL_DEVICE_SINGLE_FP_CONFIG, fpConfig.sizeof, &fpConfig, null), __FILE__, __LINE__);

		checkError(clGetDeviceInfo(id, CL_DEVICE_BUILT_IN_KERNELS, buf.sizeof, &buf, null), __FILE__, __LINE__);
		builtInKernels ~= buf[0..buf.indexOf(0)];

        checkError(clGetDeviceInfo(id, CL_DEVICE_IMAGE_SUPPORT, imageSupport.sizeof, &imageSupport, null), __FILE__, __LINE__);
        checkError(clGetDeviceInfo(id, CL_DEVICE_IMAGE2D_MAX_WIDTH, imageMaxWidth.sizeof, &imageMaxWidth, null), __FILE__, __LINE__);
        checkError(clGetDeviceInfo(id, CL_DEVICE_IMAGE2D_MAX_HEIGHT, imageMaxHeight.sizeof, &imageMaxHeight, null), __FILE__, __LINE__);

        checkError(clGetDeviceInfo(id, CL_DEVICE_LINKER_AVAILABLE, linkerAvailable.sizeof, &linkerAvailable, null), __FILE__, __LINE__);

        checkError(clGetDeviceInfo(id, CL_DEVICE_OPENCL_C_VERSION, buf.sizeof, &buf, null), __FILE__, __LINE__);
        cVersion ~= buf[0..buf.indexOf(0)];

        checkError(clGetDeviceInfo(id, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, cacheLineSize.sizeof, &cacheLineSize, null), __FILE__, __LINE__);
        checkError(clGetDeviceInfo(id, CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT, nativeVectorWidthFloat.sizeof, &nativeVectorWidthFloat, null), __FILE__, __LINE__);
        checkError(clGetDeviceInfo(id, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, preferredVectorWidthFloat.sizeof, &preferredVectorWidthFloat, null), __FILE__, __LINE__);





	}
	void destroy() {

	}
	
	override string toString() {
		string s = "";
		s ~= "Type                : ";
		final switch(type) {
			case CL_DEVICE_TYPE_DEFAULT		: s ~= "DEFAULT"; break;
			case CL_DEVICE_TYPE_CPU			: s ~= "CPU"; break;
			case CL_DEVICE_TYPE_GPU			: s ~= "GPU"; break;
			case CL_DEVICE_TYPE_ACCELERATOR	: s ~= "ACCELERATOR"; break;
			case CL_DEVICE_TYPE_ALL			: s ~= "ALL"; break;
		}

		s ~= "\n";
		s ~= "Name                : " ~ name ~ "\n";
		s ~= "Vendor              : " ~ vendor ~ "\n";
		s ~= "Available?          : " ~ (available?"yes":"no") ~ "\n";
		s ~= "Device ver          : " ~ deviceVer ~ "\n";
		s ~= "Driver ver          : " ~ driverVer ~ "\n";
		s ~= "C version           : " ~ cVersion ~ "\n";
		s ~= "Max compute units   : " ~ to!(string)(cast(uint)maxComputeUnits) ~ "\n";
		s ~= "Max work item dims  : " ~ to!(string)(cast(uint)maxWorkItemDims) ~ "\n";
		s ~= "Max work item sizes : ";
		for(uint i=0; i<maxWorkItemSizes.length; i++) {
			if(i>0) s ~= " "; 
			s ~= to!string(maxWorkItemSizes[i]);
		}
		s ~= "\n";
		
		s ~= "Max work group size : " ~ to!(string)(maxWorkGroupSize) ~ "\n";
		s ~= "Max clock frequency : " ~ to!(string)(cast(uint)maxClockFreq) ~ "\n";
		s ~= "Max mem alloc size  : " ~ to!(string)(maxMemAllocSize/(1024*1024)) ~ " MBs\n";
		s ~= "Global mem size     : " ~ to!(string)(globalMemSize/(1024*1024)) ~ " MBs\n";
		s ~= "Local mem size      : " ~ to!(string)(localMemSize/1024) ~ " KBs\n";
		s ~= "Max const buf size  : " ~ to!(string)(maxConstantBufferSize/1024) ~ " KBs\n";
		s ~= "Max const args      : " ~ to!(string)(cast(uint)maxConstantArgs) ~ "\n";

		s ~= "Compiler available? : " ~ (compilerAvailable?"yes":"no") ~ "\n";
		s ~= "Linker available?   : " ~ (linkerAvailable?"yes":"no") ~ "\n";
		s ~= "Little endian?      : " ~ (littleEndian?"yes":"no") ~ "\n";
		s ~= "Error correction?   : " ~ (errorCorrection?"yes":"no") ~ "\n";

		s ~= "Profiling timer res : " ~ to!(string)(timerResolution) ~ " nanoseconds\n";
		s ~= "Extensions          : " ~ extensions ~ "\n";
		s ~= "Built-in kernels    : " ~ builtInKernels ~ "\n";
		s ~= "Image support       : " ~ (imageSupport?"yes":"no") ~ "\n";
		s ~= "Image max w,h       : " ~ imageMaxWidth.to!string ~ "," ~
		                                imageMaxHeight.to!string ~ "\n";
		
		s ~= "Queue properties    : ";
		if(queueProperties & CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE) s ~= "CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE ";
		if(queueProperties & CL_QUEUE_PROFILING_ENABLE) s ~= "CL_QUEUE_PROFILING_ENABLE";
		s ~= "\n";
		
		s ~= "Execution caps	    : ";
		if(execCaps & CL_EXEC_KERNEL) s ~= "CL_EXEC_KERNEL ";
		if(execCaps & CL_EXEC_NATIVE_KERNEL) s ~= "CL_EXEC_NATIVE_KERNEL";
		s ~= "\n";
		
		s ~= "Single FP config    : ";
		if(fpConfig & CL_FP_DENORM) s ~= "CL_FP_DENORM ";
		if(fpConfig & CL_FP_INF_NAN) s ~= "CL_FP_INF_NAN ";
		if(fpConfig & CL_FP_ROUND_TO_NEAREST) s ~= "CL_FP_ROUND_TO_NEAREST ";
		if(fpConfig & CL_FP_ROUND_TO_ZERO) s ~= "CL_FP_ROUND_TO_ZERO ";
		if(fpConfig & CL_FP_ROUND_TO_INF) s ~= "CL_FP_ROUND_TO_INF ";
		if(fpConfig & CL_FP_FMA) s ~= "CL_FP_FMA ";
		s ~= "\n";

		s ~= "Global mem cacheLineSize      : "~to!string(cacheLineSize) ~ "\n";
		s ~= "Native vector width(float)    : "~to!string(nativeVectorWidthFloat) ~ "\n";
		s ~= "Preferred vector width(float) : "~to!string(preferredVectorWidthFloat) ~ "\n";
		s ~= "\n";
		return s;
	}
}

