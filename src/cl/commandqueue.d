module cl.commandqueue;

import cl.all;

final class CLCommandQueue {
	CLContext context;
	CLDevice device;
	cl_command_queue id;
	bool profile;

    this(CLContext context, CLDevice device, cl_command_queue id, bool profile) {
        this.context = context;
        this.device  = device;
        this.id      = id;
        this.profile = profile;
    }
	void destroy() {
        if(id) clReleaseCommandQueue(id); id = null;
	}

    void enqueueBarrier(cl_event[] waitList=null, cl_event* event=null) {
        cl_int err = clEnqueueBarrierWithWaitList(
         	id,
          	cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
        checkError(err, __FILE__, __LINE__);
    }

    /**
     *  Fill entire buffer with value.
     */
	void enqueueFillBuffer(T)(CLBuffer buffer,
	                          T value,
	                          cl_event[] waitList=null,
                              cl_event* event=null)
	{
        cl_int err = clEnqueueFillBuffer(
            id,
          	buffer.id,
          	&value,
          	T.sizeof,       // pattern size
          	0,              // offset
          	buffer.size,    // size
          	cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
        checkError(err, __FILE__, __LINE__);
	}

    // copy whole buffer (assumes same size)
	void enqueueCopyBuffer(CLBuffer src,
	                       CLBuffer dest,
	                       cl_event[] waitList=null,
	                       cl_event* event=null)
    {
        enqueueCopyBuffer(src, dest, 0, 0, src.size, waitList, event);
    }
	/// copy partial buffer
	void enqueueCopyBuffer(CLBuffer src,
	                       CLBuffer dest,
	                       size_t srcOffset,
	                       size_t destOffset,
                           size_t numBytes,
                           cl_event[] waitList=null,
                           cl_event* event=null)
    {
		cl_int err = clEnqueueCopyBuffer(
		    id,
            src.id,
            dest.id,
            srcOffset,                  // src offset
            destOffset,                 // dest offset
            numBytes, 	                // num bytes
            cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
		checkError(err, __FILE__, __LINE__);
	}
	void enqueueCopyBufferToImage(CLBuffer src,
	                              CLBuffer dest,
	                              uint width,
	                              uint height,
	                              cl_event[] waitList=null,
	                              cl_event* event=null)
    {
	    size_t[3] dest_origin = [0,0,0];
	    size_t[3] region = [width,height,1];
        cl_int err = clEnqueueCopyBufferToImage(
            id,
            src.id,
            dest.id,
            0,                          // src offset
            dest_origin.ptr,            // dest origin
            region.ptr,                 // region
            cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
        checkError(err, __FILE__, __LINE__);
    }
    void enqueueReadBuffer(CLBuffer buf,
                           void* dest,
                           cl_event[] waitList=null,
                           bool block=false,
                           cl_event* event=null)
    {
        enqueueReadBuffer(
            buf, dest, 0, buf.size, waitList, block, event
        );
    }
    /// read partial buffer
	void enqueueReadBuffer(CLBuffer buf,
	                       void* dest,
	                       size_t readOffset,
	                       size_t numBytes,
	                       cl_event[] waitList=null,
	                       bool block=false, cl_event* event=null)
    {
		cl_int err = clEnqueueReadBuffer(
		    id,
            buf.id,
            block.toCLBool, 	// blocking
            readOffset, 		// read offset
            numBytes,    		// num bytes to read
            dest, 				// dest ptr
            cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
		checkError(err, __FILE__, __LINE__);
	}
	/// write whole buffer
	void enqueueWriteBuffer(CLBuffer dest,
	                        void* src,
	                        cl_event[] waitList=null,
	                        bool block=false,
	                        cl_event* event=null)
    {
        enqueueWriteBuffer(
            dest, src, 0, dest.size, waitList, block, event
        );
    }
    /// write partial buffer
	void enqueueWriteBuffer(CLBuffer dest,
	                        void* src,
	                        size_t destOffset,
	                        size_t numBytes,
	                        cl_event[] waitList=null,
	                        bool block=false,
	                        cl_event* event=null)
    {
		cl_int err = clEnqueueWriteBuffer(
		    id,
            dest.id, 				    // buffer
            block.toCLBool, 		    // blocking
            destOffset, 			    // write offset
            numBytes,   			    // num bytes to write
            src, 					    // source ptr
            cast(uint)waitList.length,  // num items in event wait list
            waitList.ptr,               // event wait list
            event                       // event
        );
		checkError(err, __FILE__, __LINE__);
	}
	void enqueueWriteBufferRect(CLBuffer dest,
	                            size_t destOffset,
	                            const(void)* hostPtr,
	                            size_t numBytes,
	                            cl_event[] waitList=null,
	                            bool block=false,
	                            cl_event* event=null)
	{
	    size_t[3] buffer_origin = [destOffset, 0, 0];
	    size_t[3] host_origin   = [0, 0, 0];
	    size_t[3] region        = [numBytes, 1, 1];
        int err = clEnqueueWriteBufferRect(
            id,
            dest.id,                    // dest buffer
            block.toCLBool,             // blocking
            buffer_origin.ptr,
            host_origin.ptr,
            region.ptr,
            0,
            0,
            0,
            0,
            hostPtr,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
        );
        checkError(err, __FILE__, __LINE__);
	}
	void enqueueWriteImage(Image image,
                           const(void)* hostPtr,
                           cl_event[] waitList=null,
	                       bool block=false,
	                       cl_event* event=null)
    {
        size_t[3] origin = [0, 0, 0];
        size_t[3] region = [image.width, image.height, 1];
        int err =  clEnqueueWriteImage(
            id,
            image.id,
            block.toCLBool,
            origin.ptr,
            region.ptr,
            0,
            0,
            hostPtr,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event
        );
        checkError(err, __FILE__, __LINE__);
    }
    void enqueueReadImage(Image image,
                          void* hostPtr,
                          cl_event[] waitList=null,
                          bool block=false,
                          cl_event* event=null)
    {
        size_t[3] origin = [0, 0, 0];
        size_t[3] region = [image.width, image.height, 1];
	    int err = clEnqueueReadImage(
            id,
            image.id,
            block.toCLBool,
            origin.ptr,
            region.ptr,
            0L,      // row pitch
            0L,      // slice pitch
            hostPtr,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
	    );
	    checkError(err, __FILE__, __LINE__);
	}
	/// https://www.khronos.org/registry/cl/sdk/1.2/docs/man/xhtml/clEnqueueAcquireGLObjects.html
	void enqueueAcquireGLObjects(CLBuffer[] objects,
                                 cl_event[] waitList=null,
                                 cl_event* event=null)
    {
	    cl_mem[] ids = objects.map!(it=>it.id).array;
        int err =  clEnqueueAcquireGLObjects(
            id,
            cast(uint)objects.length,
            ids.ptr,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
        );
        checkError(err, __FILE__, __LINE__);
	}
	/// https://www.khronos.org/registry/cl/sdk/1.2/docs/man/xhtml/clEnqueueReleaseGLObjects.html
	void enqueueReleaseGLObjects(CLBuffer[] objects,
	                             cl_event[] waitList=null,
	                             cl_event* event=null)
	{
        cl_mem[] ids = objects.map!(it=>it.id).array;
        int err =  clEnqueueReleaseGLObjects(
            id,
            cast(uint)objects.length,
            ids.ptr,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
        );
        checkError(err, __FILE__, __LINE__);
    }
    /// Maps a region of buffer into the host address space
    /// and returns a pointer to this mapped region
    /// flags: CL_MAP_READ, CL_MAP_WRITE
    void* enqueueMapBuffer(CLBuffer buf,
                          size_t offset,
                          size_t numBytes,
                          cl_map_flags flags,
                          cl_event[] waitList=null,
                          bool block=false,
                          cl_event* event=null)
    {
       int err;
       void* ptr = clEnqueueMapBuffer(
            id,
            buf.id,
            block.toCLBool,
            flags,
            offset,
            numBytes,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event,                        // event
            &err
       );
       checkError(err, __FILE__, __LINE__);
       return ptr;
    }
    /// unmap a previously mapped region of a memory object
    void enqueueUnmapMemObject(CLBuffer buf,
                              void* ptr,
                              cl_event[] waitList=null,
                              cl_event* event=null)
    {
        int err =  clEnqueueUnmapMemObject(
            id,
            buf.id,
            ptr,
            cast(uint)waitList.length,   // num items in event wait list
            waitList.ptr,                // event wait list
            event                        // event
        );
        checkError(err, __FILE__, __LINE__);
    }
	/// enqueue multiple work items
    /// Note: Set localSizes to null to let OpenCL
    ///       determine the work group sizes
	void enqueueKernel(CLKernel kernel,
	                   size_t[] globalSizes,
	                   size_t[] localSizes=null,
	                   cl_event[] waitList=null,
	                   cl_event* event=null)
    {
		cl_int errNum = clEnqueueNDRangeKernel(
		    id,
            kernel.id,
            cast(uint)globalSizes.length, // work dimensions
            null, 			              // global work offset
            globalSizes.ptr, 	          // global work size
            localSizes.ptr, 	          // local work size
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
        );
		checkError(errNum, __FILE__, __LINE__);
	}
	/// enqueue single work item
	void enqueueKernel(CLKernel kernel,
	                   cl_event[] waitList=null,
	                   cl_event* event=null)
    {
		cl_int errNum = clEnqueueTask(
		    id,
            kernel.id,
            cast(uint)waitList.length,    // num items in event wait list
            waitList.ptr,                 // event wait list
            event                         // event
        );
		checkError(errNum, __FILE__, __LINE__);
	}
	void flush() {
    	checkError(clFlush(id), __FILE__, __LINE__);
	}
	void finish() {
		checkError(clFinish(id), __FILE__, __LINE__);
	}
}