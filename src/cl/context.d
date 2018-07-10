module cl.context;

import cl.all;

final class CLContext {
private:
	cl_context contextId;
	CLPlatform platform;
	CLDevice[] devices;
	MemObject[] memObjects;
	CLCommandQueue[] queues;
	CLProgram[] programs;
public:
	this(CLPlatform platform, CLDevice[] devices, cl_context_properties[] props) {
		this.platform = platform;

		cl_int err;
		cl_device_id* deviceIds = cast(cl_device_id*)malloc(cl_device_id.sizeof * devices.length);

        props ~= [
            CL_CONTEXT_PLATFORM,
            cast(cl_context_properties)platform.id,
            cast(cl_context_properties)0
        ];
		
		for(int i=0; i<devices.length; i++) {
			auto d = devices[i];
			this.devices ~= d;
			deviceIds[i] = d.id;
		}

		log("props=%s", props);
		
		contextId = clCreateContext(
		    props.ptr,
		    cast(uint)devices.length,
		    deviceIds,
		    null,
		    null,
		    &err
		);
		//contextId = clCreateContextFromType(props, CL_DEVICE_TYPE_GPU, null, null, &err);
		checkError(err, __FILE__, __LINE__);

		free(deviceIds);
		
		/*
		// get the list of devices associated with context
		size_t numBytes;
	    err = clGetContextInfo(contextId, CL_CONTEXT_DEVICES, 0, null, &numBytes);
	    checkError(err);
	    assert(numBytes);
	    cl_device_id* devices = cast(cl_device_id*)malloc(numBytes);
	    err = clGetContextInfo(contextId, CL_CONTEXT_DEVICES, numBytes, devices, null);
	    checkError(err);
	    
	    // pick the 1st device
	    deviceId = devices[0];
	    free(devices);
	    */
	}
	void destroy() {
	    memObjects.each!(it=>it.destroy());
	    queues.each!(it=>it.destroy());
	    programs.each!(it=>it.destroy());
	    memObjects.length = 0;
        queues.length = 0;
        programs.length = 0;
        if(contextId) clReleaseContext(contextId); contextId = null;
	}

	cl_context id() { return contextId; }
	CLDevice[] getDevices() { return devices; }

    /**
     * Create an OpenCL2.0 queue that supports
     * device kernel_enqueue.
     */
    CLCommandQueue createQueueOnDevice(CLDevice device, ulong size=262144L) {
        auto queueProps = 0L |
            CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE |
            CL_QUEUE_ON_DEVICE |
            CL_QUEUE_ON_DEVICE_DEFAULT;

        ulong[] props = [
            CL_QUEUE_PROPERTIES,
            queueProps,
            CL_QUEUE_SIZE,
            size,
            0L
        ];
        int err;
        auto queueId = clCreateCommandQueueWithProperties(
            contextId,
            device.id,
            props.ptr,
            &err
        );
        checkError(err, __FILE__, __LINE__);
        auto q = new CLCommandQueue(this, device, queueId, false);
        queues ~= q;
        return q;
    }
    CLCommandQueue createQueue(CLDevice device, bool profile) {
        cl_command_queue_properties queue_properties = 0;
        if(profile) {
            queue_properties |= CL_QUEUE_PROFILING_ENABLE;
        }
        //queue_properties |= CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE;

        int err;
        auto queueId = clCreateCommandQueue(
            contextId,
            device.id,
            queue_properties,
            &err);
        checkError(err, __FILE__, __LINE__);
        auto q = new CLCommandQueue(this, device, queueId, profile);
        queues ~= q;
        return q;
    }
	//CLCommandQueue createQueue(bool profile) {
	//	auto q = new CLCommandQueue(this, devices[0], profile);
	//	queues ~= q;
	//	return q;
	//}
	/**
	 *  CL_MEM_READ_ONLY, CL_MEM_WRITE_ONLY, CL_MEM_READ_WRITE
	 *  CL_MEM_HOST_READ_ONLY, CL_MEM_HOST_WRITE_ONLY, CL_MEM_HOST_NO_ACCESS
	 *  CL_MEM_ALLOC_HOST_PTR, CL_MEM_COPY_HOST_PTR, CL_MEM_USE_HOST_PTR
	 */
	CLBuffer createBuffer(cl_mem_flags flags,
	                      size_t numBytes,
	                      void* hostPtr=null)
    {
	    int err;
        cl_mem id = clCreateBuffer(
            contextId,
            flags,
            numBytes,
            hostPtr,
            &err
        );
        checkError(err, __FILE__, __LINE__);
		auto b = new CLBuffer(id, flags, numBytes);
		memObjects ~= b;
		return b;
	}
	Image createImage(cl_mem_flags flags,
	                   cl_image_format format,
	                   cl_image_desc desc,
	                   void* hostPtr)
    {
	    int err;
	    cl_mem id = clCreateImage(
	        contextId,
            flags,
            &format,
            &desc,
            hostPtr,
            &err
	    );
	    checkError(err, __FILE__, __LINE__);
        auto b = new Image(id, flags,
                           cast(uint)desc.image_width,
                           cast(uint)desc.image_height);
        memObjects ~= b;
        return b;
	}
    /// https://www.khronos.org/registry/cl/sdk/1.2/docs/man/xhtml/clCreateFromGLTexture.html
    /// flags:  CL_MEM_READ_ONLY, CL_MEM_WRITE_ONLY or CL_MEM_READ_WRITE
    /// target: eg GL_TEXTURE_2D
    CLBuffer createFromGLTexture(cl_mem_flags flags,
                                 uint textureId,
                                 uint target,
                                 size_t numBytes,
                                 int mipLevel=0)
    {
        int err;
        cl_mem id = clCreateFromGLTexture(
            contextId,
            flags,
            target,
            mipLevel,
            textureId,
            &err
        );
        checkError(err, __FILE__, __LINE__);
        auto b = new CLBuffer(id, flags, numBytes);
        memObjects ~= b;
        return b;
    }
	CLProgram getProgram(string filename, string[] options, bool warningsAsErrors=true) {
		for(int i=0; i<programs.length; i++) {
			if(filename==programs[i].getFilename()) return programs[i];
		}
		auto p = new CLProgram(this, devices[0], filename, options, warningsAsErrors);
		programs ~= p;
		return p;
	}
}

