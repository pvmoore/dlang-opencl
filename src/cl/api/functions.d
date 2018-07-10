module cl.api.functions;

import cl.all;
import core.sys.windows.windows	: HMODULE, GetProcAddress;

void loadFunctions_1_0(HMODULE handle) {
    *(cast(void**)&clGetPlatformIDs) = GetProcAddress(handle, "clGetPlatformIDs"); assert(clGetPlatformIDs);
    *(cast(void**)&clGetPlatformInfo) = GetProcAddress(handle, "clGetPlatformInfo"); assert(clGetPlatformInfo);
    *(cast(void**)&clGetDeviceIDs) = GetProcAddress(handle, "clGetDeviceIDs"); assert(clGetDeviceIDs);
    *(cast(void**)&clGetDeviceInfo) = GetProcAddress(handle, "clGetDeviceInfo"); assert(clGetDeviceInfo);
    *(cast(void**)&clCreateContext) = GetProcAddress(handle, "clCreateContext"); assert(clCreateContext);
    *(cast(void**)&clCreateContextFromType) = GetProcAddress(handle, "clCreateContextFromType"); assert(clCreateContextFromType);
    *(cast(void**)&clRetainContext) = GetProcAddress(handle, "clRetainContext"); assert(clRetainContext);
    *(cast(void**)&clReleaseContext) = GetProcAddress(handle, "clReleaseContext"); assert(clReleaseContext);
    *(cast(void**)&clGetContextInfo) = GetProcAddress(handle, "clGetContextInfo"); assert(clGetContextInfo);

    *(cast(void**)&clRetainCommandQueue) = GetProcAddress(handle, "clRetainCommandQueue"); assert(clRetainCommandQueue);
    *(cast(void**)&clReleaseCommandQueue) = GetProcAddress(handle, "clReleaseCommandQueue"); assert(clReleaseCommandQueue);
    *(cast(void**)&clGetCommandQueueInfo) = GetProcAddress(handle, "clGetCommandQueueInfo"); assert(clGetCommandQueueInfo);

    *(cast(void**)&clCreateBuffer) = GetProcAddress(handle, "clCreateBuffer"); assert(clCreateBuffer);
    *(cast(void**)&clRetainMemObject) = GetProcAddress(handle, "clRetainMemObject"); assert(clRetainMemObject);
    *(cast(void**)&clReleaseMemObject) = GetProcAddress(handle, "clReleaseMemObject"); assert(clReleaseMemObject);
    *(cast(void**)&clGetSupportedImageFormats) = GetProcAddress(handle, "clGetSupportedImageFormats"); assert(clGetSupportedImageFormats);
    *(cast(void**)&clGetMemObjectInfo) = GetProcAddress(handle, "clGetMemObjectInfo"); assert(clGetMemObjectInfo);
    *(cast(void**)&clGetImageInfo) = GetProcAddress(handle, "clGetImageInfo"); assert(clGetImageInfo);

    *(cast(void**)&clRetainSampler) = GetProcAddress(handle, "clRetainSampler"); assert(clRetainSampler);
    *(cast(void**)&clReleaseSampler) = GetProcAddress(handle, "clReleaseSampler"); assert(clReleaseSampler);
    *(cast(void**)&clGetSamplerInfo) = GetProcAddress(handle, "clGetSamplerInfo"); assert(clGetSamplerInfo);

    *(cast(void**)&clCreateProgramWithSource) = GetProcAddress(handle, "clCreateProgramWithSource"); assert(clCreateProgramWithSource);
    *(cast(void**)&clCreateProgramWithBinary) = GetProcAddress(handle, "clCreateProgramWithBinary"); assert(clCreateProgramWithBinary);
    *(cast(void**)&clRetainProgram) = GetProcAddress(handle, "clRetainProgram"); assert(clRetainProgram);
    *(cast(void**)&clReleaseProgram) = GetProcAddress(handle, "clReleaseProgram"); assert(clReleaseProgram);
    *(cast(void**)&clBuildProgram) = GetProcAddress(handle, "clBuildProgram"); assert(clBuildProgram);
    *(cast(void**)&clGetProgramInfo) = GetProcAddress(handle, "clGetProgramInfo"); assert(clGetProgramInfo);
    *(cast(void**)&clGetProgramBuildInfo) = GetProcAddress(handle, "clGetProgramBuildInfo"); assert(clGetProgramBuildInfo);
    *(cast(void**)&clCreateKernel) = GetProcAddress(handle, "clCreateKernel"); assert(clCreateKernel);

    *(cast(void**)&clCreateKernelsInProgram) = GetProcAddress(handle, "clCreateKernelsInProgram"); assert(clCreateKernelsInProgram);
    *(cast(void**)&clRetainKernel) = GetProcAddress(handle, "clRetainKernel"); assert(clRetainKernel);
    *(cast(void**)&clReleaseKernel) = GetProcAddress(handle, "clReleaseKernel"); assert(clReleaseKernel);
    *(cast(void**)&clSetKernelArg) = GetProcAddress(handle, "clSetKernelArg"); assert(clSetKernelArg);
    *(cast(void**)&clGetKernelInfo) = GetProcAddress(handle, "clGetKernelInfo"); assert(clGetKernelInfo);
    *(cast(void**)&clGetKernelWorkGroupInfo) = GetProcAddress(handle, "clGetKernelWorkGroupInfo"); assert(clGetKernelWorkGroupInfo);

    *(cast(void**)&clWaitForEvents) = GetProcAddress(handle, "clWaitForEvents"); assert(clWaitForEvents);
    *(cast(void**)&clGetEventInfo) = GetProcAddress(handle, "clGetEventInfo"); assert(clGetEventInfo);
    *(cast(void**)&clRetainEvent) = GetProcAddress(handle, "clRetainEvent"); assert(clRetainEvent);
    *(cast(void**)&clReleaseEvent) = GetProcAddress(handle, "clReleaseEvent"); assert(clReleaseEvent);

    *(cast(void**)&clGetEventProfilingInfo) = GetProcAddress(handle, "clGetEventProfilingInfo"); assert(clGetEventProfilingInfo);

    *(cast(void**)&clFlush) = GetProcAddress(handle, "clFlush"); assert(clFlush);
    *(cast(void**)&clFinish) = GetProcAddress(handle, "clFinish"); assert(clFinish);

    *(cast(void**)&clEnqueueReadBuffer) = GetProcAddress(handle, "clEnqueueReadBuffer"); assert(clEnqueueReadBuffer);
    *(cast(void**)&clEnqueueWriteBuffer) = GetProcAddress(handle, "clEnqueueWriteBuffer"); assert(clEnqueueWriteBuffer);
    *(cast(void**)&clEnqueueCopyBuffer) = GetProcAddress(handle, "clEnqueueCopyBuffer"); assert(clEnqueueCopyBuffer);
    *(cast(void**)&clEnqueueReadImage) = GetProcAddress(handle, "clEnqueueReadImage"); assert(clEnqueueReadImage);
    *(cast(void**)&clEnqueueWriteImage) = GetProcAddress(handle, "clEnqueueWriteImage"); assert(clEnqueueWriteImage);
    *(cast(void**)&clEnqueueCopyImage) = GetProcAddress(handle, "clEnqueueCopyImage"); assert(clEnqueueCopyImage);
    *(cast(void**)&clEnqueueCopyImageToBuffer) = GetProcAddress(handle, "clEnqueueCopyImageToBuffer"); assert(clEnqueueCopyImageToBuffer);
    *(cast(void**)&clEnqueueCopyBufferToImage) = GetProcAddress(handle, "clEnqueueCopyBufferToImage"); assert(clEnqueueCopyBufferToImage);
    *(cast(void**)&clEnqueueMapBuffer) = GetProcAddress(handle, "clEnqueueMapBuffer"); assert(clEnqueueMapBuffer);
    *(cast(void**)&clEnqueueMapImage) = GetProcAddress(handle, "clEnqueueMapImage"); assert(clEnqueueMapImage);
    *(cast(void**)&clEnqueueUnmapMemObject) = GetProcAddress(handle, "clEnqueueUnmapMemObject"); assert(clEnqueueUnmapMemObject);
    *(cast(void**)&clEnqueueNDRangeKernel) = GetProcAddress(handle, "clEnqueueNDRangeKernel"); assert(clEnqueueNDRangeKernel);
    *(cast(void**)&clEnqueueNativeKernel) = GetProcAddress(handle, "clEnqueueNativeKernel"); assert(clEnqueueNativeKernel);

    // GL functions
    *(cast(void**)&clCreateFromGLBuffer) = GetProcAddress(handle, "clCreateFromGLBuffer"); assert(clCreateFromGLBuffer);
    *(cast(void**)&clCreateFromGLRenderbuffer) = GetProcAddress(handle, "clCreateFromGLRenderbuffer"); assert(clCreateFromGLRenderbuffer);
    *(cast(void**)&clGetGLObjectInfo) = GetProcAddress(handle, "clGetGLObjectInfo"); assert(clGetGLObjectInfo);
    *(cast(void**)&clGetGLTextureInfo) = GetProcAddress(handle, "clGetGLTextureInfo"); assert(clGetGLTextureInfo);
    *(cast(void**)&clEnqueueAcquireGLObjects) = GetProcAddress(handle, "clEnqueueAcquireGLObjects"); assert(clEnqueueAcquireGLObjects);
    *(cast(void**)&clEnqueueReleaseGLObjects) = GetProcAddress(handle, "clEnqueueReleaseGLObjects"); assert(clEnqueueReleaseGLObjects);
    //*(cast(void**)&clGetGLContextInfoKHR) = GetProcAddress(handle, "clGetGLContextInfoKHR"); assert(clGetGLContextInfoKHR);

    // deprecated in 1.1
    *(cast(void**)&clSetCommandQueueProperty) = GetProcAddress(handle, "clSetCommandQueueProperty"); assert(clSetCommandQueueProperty);

    // deprecated in 1.2
    *(cast(void**)&clCreateImage2D) = GetProcAddress(handle, "clCreateImage2D"); assert(clCreateImage2D);
    *(cast(void**)&clCreateImage3D) = GetProcAddress(handle, "clCreateImage3D"); assert(clCreateImage3D);
    *(cast(void**)&clEnqueueMarker) = GetProcAddress(handle, "clEnqueueMarker"); assert(clEnqueueMarker);
    *(cast(void**)&clEnqueueWaitForEvents) = GetProcAddress(handle, "clEnqueueWaitForEvents"); assert(clEnqueueWaitForEvents);
    *(cast(void**)&clEnqueueBarrier) = GetProcAddress(handle, "clEnqueueBarrier"); assert(clEnqueueBarrier);
    *(cast(void**)&clUnloadCompiler) = GetProcAddress(handle, "clUnloadCompiler"); assert(clUnloadCompiler);
    *(cast(void**)&clGetExtensionFunctionAddress) = GetProcAddress(handle, "clGetExtensionFunctionAddress"); assert(clGetExtensionFunctionAddress);

    // deprecated in 2.0
    *(cast(void**)&clCreateCommandQueue) = GetProcAddress(handle, "clCreateCommandQueue"); assert(clCreateCommandQueue);
    *(cast(void**)&clCreateSampler) = GetProcAddress(handle, "clCreateSampler"); assert(clCreateSampler);
    *(cast(void**)&clEnqueueTask) = GetProcAddress(handle, "clEnqueueTask"); assert(clEnqueueTask);

}
void loadFunctions_1_1(HMODULE handle) {
    //clCreateFromGLTexture2D (deprecated in 1.2)
    //clCreateFromGLTexture3D (deprecated in 1.2)
    //clCreateSubBuffer
    //clSetMemObjectDestructorCallback
    //clCreateUserEvent
    //clSetUserEventStatus
    //clSetEventCallback
    //clEnqueueReadBufferRect
    //clEnqueueWriteBufferRect
    //clEnqueueCopyBufferRect
}
void loadFunctions_1_2(HMODULE handle) {
    //clCreateSubDevices
    //clRetainDevice
    //clReleaseDevice
    //clCreateImage
    //clCompileProgram
    //clLinkProgram
    //clUnloadPlatformCompiler
    //clEnqueueFillBuffer
    //clEnqueueFillImage
    //clEnqueueMigrateMemObjects
    //clEnqueueMarkerWithWaitList
    //clEnqueueBarrierWithWaitList
    //clGetExtensionFunctionAddressForPlatform

    *(cast(void**)&clCreateFromGLTexture) = GetProcAddress(handle, "clCreateFromGLTexture"); assert(clCreateFromGLTexture);
}
void loadFunctions_2_0(HMODULE handle) {

}

extern(Windows) {

//Platform API
__gshared cl_int function(cl_uint          /* num_entries */,
                cl_platform_id * /* platforms */,
                cl_uint *        /* num_platforms */) clGetPlatformIDs;

__gshared cl_int function(cl_platform_id   /* platform */,
                cl_platform_info /* param_name */,
                size_t           /* param_value_size */,
                void *           /* param_value */,
                size_t *         /* param_value_size_ret */) clGetPlatformInfo;

//Device APIs
__gshared cl_int function(cl_platform_id   /* platform */,
                cl_device_type   /* device_type */,
                cl_uint          /* num_entries */,
                cl_device_id *   /* devices */,
                cl_uint *        /* num_devices */) clGetDeviceIDs;

__gshared cl_int function(cl_device_id    /* device */,
                cl_device_info  /* param_name */,
                size_t          /* param_value_size */,
                void *          /* param_value */,
                size_t *        /* param_value_size_ret */) clGetDeviceInfo;

//Context APIs
__gshared cl_context function(cl_context_properties*  						/* properties */,
                	cl_uint                 						/* num_devices */,
                	cl_device_id *    								/* devices */,
                	//void (*pfn_notify)(char*, void*, size_t, void*) /* pfn_notify */,
					void function(char*, void*, size_t, void*),		/* pfn_notify */
                	void *                  						/* user_data */,
                	cl_int *                						/* errcode_ret */) clCreateContext;

__gshared cl_context function(cl_context_properties * 						    /* properties */,
                    cl_device_type          							/* device_type */,
                    //void (*pfn_notify)(char *, void *, size_t, void *) 	/* pfn_notify */,
					void function(char *, void *, size_t, void *),		/* pfn_notify */
                    void *                  							/* user_data */,
                    cl_int *                							/* errcode_ret */) clCreateContextFromType;

__gshared cl_int function(cl_context /* context */) clRetainContext;

__gshared cl_int function(cl_context /* context */) clReleaseContext;

__gshared cl_int function(cl_context         /* context */,
                cl_context_info    /* param_name */,
                size_t             /* param_value_size */,
                void *             /* param_value */,
                size_t *           /* param_value_size_ret */) clGetContextInfo;

//Command Queue APIs
__gshared cl_command_queue function(cl_context                     /* context */,
                     	  cl_device_id                   /* device */,
                     	  cl_command_queue_properties    /* properties */,
                     	  cl_int *                       /* errcode_ret */) clCreateCommandQueue;

__gshared cl_int function(cl_command_queue /* command_queue */) clRetainCommandQueue;

__gshared cl_int function(cl_command_queue /* command_queue */) clReleaseCommandQueue;

__gshared cl_int function(cl_command_queue      /* command_queue */,
                cl_command_queue_info /* param_name */,
                size_t                /* param_value_size */,
                void *                /* param_value */,
                size_t *              /* param_value_size_ret */) clGetCommandQueueInfo;

__gshared cl_int function(cl_command_queue              /* command_queue */,
                cl_command_queue_properties   /* properties */,
                cl_bool                       /* enable */,
                cl_command_queue_properties * /* old_properties */) clSetCommandQueueProperty;

//Memory Object APIs
__gshared cl_mem function(cl_context   /* context */,
                cl_mem_flags /* flags */,
                size_t       /* size */,
                void *       /* host_ptr */,
                cl_int *     /* errcode_ret */) clCreateBuffer;

__gshared cl_mem function(cl_context              /* context */,
                cl_mem_flags            /* flags */,
                cl_image_format * 	    /* image_format */,
                size_t                  /* image_width */,
                size_t                  /* image_height */,
                size_t                  /* image_row_pitch */,
                void *                  /* host_ptr */,
                cl_int *                /* errcode_ret */) clCreateImage2D;

__gshared cl_mem function(cl_context              /* context */,
                cl_mem_flags            /* flags */,
                cl_image_format * 		/* image_format */,
                size_t                  /* image_width */,
                size_t                  /* image_height */,
                size_t                  /* image_depth */,
                size_t                  /* image_row_pitch */,
                size_t                  /* image_slice_pitch */,
                void *                  /* host_ptr */,
                cl_int *                /* errcode_ret */) clCreateImage3D;

__gshared cl_int function(cl_mem /* memobj */) clRetainMemObject;

__gshared cl_int function(cl_mem /* memobj */) clReleaseMemObject;

__gshared cl_int function(cl_context           /* context */,
                cl_mem_flags         /* flags */,
                cl_mem_object_type   /* image_type */,
                cl_uint              /* num_entries */,
                cl_image_format *    /* image_formats */,
                cl_uint *            /* num_image_formats */) clGetSupportedImageFormats;

__gshared cl_int function(cl_mem           /* memobj */,
                cl_mem_info      /* param_name */,
                size_t           /* param_value_size */,
                void *           /* param_value */,
                size_t *         /* param_value_size_ret */) clGetMemObjectInfo;

__gshared cl_int function(cl_mem           /* image */,
                cl_image_info    /* param_name */,
                size_t           /* param_value_size */,
                void *           /* param_value */,
                size_t *         /* param_value_size_ret */) clGetImageInfo;

//Sampler APIs
__gshared cl_sampler function(cl_context          /* context */,
                	cl_bool             /* normalized_coords */,
                	cl_addressing_mode  /* addressing_mode */,
                	cl_filter_mode      /* filter_mode */,
                	cl_int *            /* errcode_ret */) clCreateSampler;

__gshared cl_int function(cl_sampler /* sampler */) clRetainSampler;

__gshared cl_int function(cl_sampler /* sampler */) clReleaseSampler;

__gshared cl_int function(cl_sampler         /* sampler */,
                cl_sampler_info    /* param_name */,
                size_t             /* param_value_size */,
                void *             /* param_value */,
                size_t *           /* param_value_size_ret */) clGetSamplerInfo;

//Program Object APIs
__gshared cl_program function(cl_context        /* context */,
                    cl_uint           /* count */,
                    char **     	  /* strings */,
                    size_t *    	  /* lengths */,
                    cl_int *          /* errcode_ret */) clCreateProgramWithSource;

__gshared cl_program function(cl_context                     /* context */,
                    cl_uint                        /* num_devices */,
                    cl_device_id *           		/* device_list */,
                    size_t *                 		/* lengths */,
                    ubyte **         				/* binaries */,
                    cl_int *                       	/* binary_status */,
                    cl_int *                       	/* errcode_ret */) clCreateProgramWithBinary;

__gshared cl_int function(cl_program /* program */) clRetainProgram;

__gshared cl_int function(cl_program /* program */) clReleaseProgram;

__gshared cl_int function(cl_program           								/* program */,
                cl_uint              								/* num_devices */,
                cl_device_id * 										/* device_list */,
                char *         										/* options */,
                //void (*pfn_notify)(cl_program /* program */, void * /* user_data */),
				void function(cl_program /* program */, void * /* user_data */),
                void *               								/* user_data */) clBuildProgram;

__gshared cl_int function() clUnloadCompiler;

__gshared cl_int function(cl_program         /* program */,
                cl_program_info    /* param_name */,
                size_t             /* param_value_size */,
                void *             /* param_value */,
                size_t *           /* param_value_size_ret */) clGetProgramInfo;

__gshared cl_int function(cl_program            /* program */,
                cl_device_id          /* device */,
                cl_program_build_info /* param_name */,
                size_t                /* param_value_size */,
                void *                /* param_value */,
                size_t *              /* param_value_size_ret */) clGetProgramBuildInfo;

//Kernel Object APIs
__gshared cl_kernel function(cl_program      		/* program */,
               	   immutable(char)*  	/* kernel_name */,
               	   cl_int*        		/* errcode_ret */) clCreateKernel;

__gshared cl_int function(cl_program     /* program */,
                cl_uint        /* num_kernels */,
                cl_kernel *    /* kernels */,
                cl_uint *      /* num_kernels_ret */) clCreateKernelsInProgram;

__gshared cl_int function(cl_kernel    /* kernel */) clRetainKernel;

__gshared cl_int function(cl_kernel   /* kernel */) clReleaseKernel;

__gshared cl_int function(cl_kernel    /* kernel */,
                cl_uint      /* arg_index */,
                size_t       /* arg_size */,
                void * 	     /* arg_value */) clSetKernelArg;

__gshared cl_int function(cl_kernel       /* kernel */,
                cl_kernel_info  /* param_name */,
                size_t          /* param_value_size */,
                void *          /* param_value */,
                size_t *        /* param_value_size_ret */) clGetKernelInfo;

__gshared cl_int function(cl_kernel                  /* kernel */,
                cl_device_id               /* device */,
                cl_kernel_work_group_info  /* param_name */,
                size_t                     /* param_value_size */,
                void *                     /* param_value */,
                size_t *                   /* param_value_size_ret */) clGetKernelWorkGroupInfo;

//Event Object APIs
__gshared cl_int function(cl_uint             /* num_events */,
                cl_event *    	    /* event_list */) clWaitForEvents;

__gshared cl_int function(cl_event         /* event */,
                cl_event_info    /* param_name */,
                size_t           /* param_value_size */,
                void *           /* param_value */,
                size_t *         /* param_value_size_ret */) clGetEventInfo;

__gshared cl_int function(cl_event /* event */) clRetainEvent;

__gshared cl_int function(cl_event /* event */) clReleaseEvent;

//Profiling APIs
__gshared cl_int function(cl_event            /* event */,
                cl_profiling_info   /* param_name */,
                size_t              /* param_value_size */,
                void *              /* param_value */,
                size_t *            /* param_value_size_ret */) clGetEventProfilingInfo;

//Flush and Finish APIs
__gshared cl_int function(cl_command_queue 	/* command_queue */) clFlush;

__gshared cl_int function(cl_command_queue 	/* command_queue */) clFinish;

//Enqueued Commands APIs
__gshared cl_int function(cl_command_queue    /* command_queue */,
                cl_mem              /* buffer */,
                cl_bool             /* blocking_read */,
                size_t              /* offset */,
                size_t              /* cb */,
                void *              /* ptr */,
                cl_uint             /* num_events_in_wait_list */,
                cl_event *    	    /* event_wait_list */,
                cl_event *          /* event */) clEnqueueReadBuffer;

__gshared cl_int function(cl_command_queue   /* command_queue */,
                cl_mem             /* buffer */,
                cl_bool            /* blocking_write */,
                size_t             /* offset */,
                size_t             /* cb */,
                void *       	   /* ptr */,
                cl_uint            /* num_events_in_wait_list */,
                cl_event *   	   /* event_wait_list */,
                cl_event *         /* event */) clEnqueueWriteBuffer;

__gshared cl_int function(cl_command_queue    /* command_queue */,
                cl_mem              /* src_buffer */,
                cl_mem              /* dst_buffer */,
                size_t              /* src_offset */,
                size_t              /* dst_offset */,
                size_t              /* cb */,
                cl_uint             /* num_events_in_wait_list */,
                cl_event *    	    /* event_wait_list */,
                cl_event *          /* event */) clEnqueueCopyBuffer;

__gshared cl_int function(cl_command_queue     /* command_queue */,
                cl_mem               /* image */,
                cl_bool              /* blocking_read */,
                size_t *       		 /* origin[3] */,
                size_t *       		 /* region[3] */,
                size_t               /* row_pitch */,
                size_t               /* slice_pitch */,
                void *               /* ptr */,
                cl_uint              /* num_events_in_wait_list */,
                cl_event *     		 /* event_wait_list */,
                cl_event *           /* event */) clEnqueueReadImage;

__gshared cl_int function(cl_command_queue    /* command_queue */,
                cl_mem              /* image */,
                cl_bool             /* blocking_write */,
                size_t *      		/* origin[3] */,
                size_t *      		/* region[3] */,
                size_t              /* input_row_pitch */,
                size_t              /* input_slice_pitch */,
                void *       		/* ptr */,
                cl_uint             /* num_events_in_wait_list */,
                cl_event *    		/* event_wait_list */,
                cl_event *          /* event */) clEnqueueWriteImage;

__gshared cl_int function(cl_command_queue     /* command_queue */,
                cl_mem               /* src_image */,
                cl_mem               /* dst_image */,
                size_t *       		 /* src_origin[3] */,
                size_t *       		 /* dst_origin[3] */,
                size_t *       		 /* region[3] */,
                cl_uint              /* num_events_in_wait_list */,
                cl_event *     		 /* event_wait_list */,
                cl_event *           /* event */) clEnqueueCopyImage;

__gshared cl_int function(cl_command_queue /* command_queue */,
                cl_mem           /* src_image */,
                cl_mem           /* dst_buffer */,
                size_t *   		 /* src_origin[3] */,
                size_t *   		 /* region[3] */,
                size_t           /* dst_offset */,
                cl_uint          /* num_events_in_wait_list */,
                cl_event * 		 /* event_wait_list */,
                cl_event *       /* event */) clEnqueueCopyImageToBuffer;

__gshared cl_int function(cl_command_queue /* command_queue */,
                cl_mem           /* src_buffer */,
                cl_mem           /* dst_image */,
                size_t           /* src_offset */,
                size_t *   		 /* dst_origin[3] */,
                size_t *   		 /* region[3] */,
                cl_uint          /* num_events_in_wait_list */,
                cl_event * 		 /* event_wait_list */,
                cl_event *       /* event */) clEnqueueCopyBufferToImage;

__gshared void * function(cl_command_queue /* command_queue */,
                cl_mem           /* buffer */,
                cl_bool          /* blocking_map */,
                cl_map_flags     /* map_flags */,
                size_t           /* offset */,
                size_t           /* cb */,
                cl_uint          /* num_events_in_wait_list */,
                cl_event * 		 /* event_wait_list */,
                cl_event *       /* event */,
                cl_int *         /* errcode_ret */) clEnqueueMapBuffer;

__gshared void * function(cl_command_queue  /* command_queue */,
                cl_mem            /* image */,
                cl_bool           /* blocking_map */,
                cl_map_flags      /* map_flags */,
                size_t *    	  /* origin[3] */,
                size_t *    	  /* region[3] */,
                size_t *          /* image_row_pitch */,
                size_t *          /* image_slice_pitch */,
                cl_uint           /* num_events_in_wait_list */,
                cl_event *  	  /* event_wait_list */,
                cl_event *        /* event */,
                cl_int *          /* errcode_ret */) clEnqueueMapImage;

__gshared cl_int function(cl_command_queue  /* command_queue */,
                cl_mem            /* memobj */,
                void *            /* mapped_ptr */,
                cl_uint           /* num_events_in_wait_list */,
                cl_event *  	  /* event_wait_list */,
                cl_event *        /* event */) clEnqueueUnmapMemObject;

__gshared cl_int function(cl_command_queue /* command_queue */,
                cl_kernel        /* kernel */,
                cl_uint          /* work_dim */,
                size_t *   		 /* global_work_offset */,
                size_t *   	 	 /* global_work_size */,
                size_t *   		 /* local_work_size */,
                cl_uint          /* num_events_in_wait_list */,
                cl_event * 		 /* event_wait_list */,
                cl_event *       /* event */) clEnqueueNDRangeKernel;

__gshared cl_int function(cl_command_queue  /* command_queue */,
                cl_kernel         /* kernel */,
                cl_uint           /* num_events_in_wait_list */,
                cl_event *  	  /* event_wait_list */,
                cl_event *        /* event */) clEnqueueTask;

__gshared cl_int function(cl_command_queue  /* command_queue */,
				//void (*user_func)(void *),
				void function(void *),
                void *            /* args */,
                size_t            /* cb_args */,
                cl_uint           /* num_mem_objects */,
                cl_mem *    	  /* mem_list */,
                void **     	  /* args_mem_loc */,
                cl_uint           /* num_events_in_wait_list */,
                cl_event *  	  /* event_wait_list */,
                cl_event *        /* event */) clEnqueueNativeKernel;

__gshared cl_int function(cl_command_queue    /* command_queue */,
                cl_event *          /* event */) clEnqueueMarker;

__gshared cl_int function(cl_command_queue /* command_queue */,
                cl_uint          /* num_events */,
                cl_event * 		 /* event_list */) clEnqueueWaitForEvents;

__gshared cl_int function(cl_command_queue /* command_queue */) clEnqueueBarrier;

__gshared cl_mem function(
    cl_context,
    cl_mem_flags,
    cl_GLenum,
    cl_GLint,
    cl_GLuint,
    cl_int*) clCreateFromGLTexture;

__gshared cl_mem function(
    cl_context,
    cl_mem_flags,
    cl_GLuint,
    int*) clCreateFromGLBuffer;

__gshared cl_mem function(
    cl_context   /* context */,
    cl_mem_flags /* flags */,
    cl_GLuint    /* renderbuffer */,
    cl_int *     /* errcode_ret */) clCreateFromGLRenderbuffer;

__gshared cl_int function(
    cl_mem                /* memobj */,
    cl_gl_object_type *   /* gl_object_type */,
    cl_GLuint *           /* gl_object_name */) clGetGLObjectInfo;

__gshared cl_int function(
    cl_mem               /* memobj */,
    cl_gl_texture_info   /* param_name */,
    size_t               /* param_value_size */,
    void *               /* param_value */,
    size_t *             /* param_value_size_ret */) clGetGLTextureInfo;

__gshared cl_int function(
    cl_command_queue      /* command_queue */,
    cl_uint               /* num_objects */,
    const(cl_mem*)        /* mem_objects */,
    cl_uint               /* num_events_in_wait_list */,
    const(cl_event*)      /* event_wait_list */,
    cl_event *            /* event */) clEnqueueAcquireGLObjects;

__gshared cl_int function(
    cl_command_queue      /* command_queue */,
    cl_uint               /* num_objects */,
    const cl_mem *        /* mem_objects */,
    cl_uint               /* num_events_in_wait_list */,
    const(cl_event*)      /* event_wait_list */,
    cl_event *            /* event */) clEnqueueReleaseGLObjects;

__gshared cl_int function(
    const(cl_context_properties*) /* properties */,
    cl_gl_context_info            /* param_name */,
    size_t                        /* param_value_size */,
    void*                         /* param_value */,
    size_t*                       /* param_value_size_ret */) clGetGLContextInfoKHR;


//Extension function access
//
// Returns the extension function address for the given function name,
// or NULL if a valid function can not be found.  The client must
// check to make sure the address is not NULL, before using or
// calling the returned function address.
//
__gshared void* function(char* /* func_name */) clGetExtensionFunctionAddress;

}

