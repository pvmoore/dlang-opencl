module cl.platform;

import cl.all;
import core.sys.windows.windows : HDC, HGLRC;

final class CLPlatform {
	cl_platform_id id;
	string name;
	string vendor;
	string ver;
	string profile;
	string extensions;
	CLContext[] contexts;

	this(cl_platform_id id) {
		this.id = id;
		
		char[1024] buf;
		checkError(clGetPlatformInfo(id, CL_PLATFORM_NAME, buf.sizeof, &buf, null), __FILE__, __LINE__);
		name ~= buf[0..indexOf(buf, 0)];
		checkError(clGetPlatformInfo(id, CL_PLATFORM_VENDOR, buf.sizeof, &buf, null), __FILE__, __LINE__);
		vendor ~= buf[0..indexOf(buf, 0)];
		checkError(clGetPlatformInfo(id, CL_PLATFORM_VERSION, buf.sizeof, &buf, null), __FILE__, __LINE__);
		ver ~= buf[0..indexOf(buf, 0)];
		checkError(clGetPlatformInfo(id, CL_PLATFORM_PROFILE, buf.sizeof, &buf, null), __FILE__, __LINE__);
		profile ~= buf[0..indexOf(buf, 0)];
		checkError(clGetPlatformInfo(id, CL_PLATFORM_EXTENSIONS, buf.sizeof, &buf, null), __FILE__, __LINE__);
		extensions ~= buf[0..indexOf(buf, 0)];
	}
	void destroy() {
        contexts.each!(it=>it.destroy()); contexts.length = 0;
	}
	CLDevice[] getDevices(cl_device_type type) {
		return getDevices().filter!(it=>it.type==type).array;
	}
	CLDevice[] getDevices() {
		CLDevice[] devices;
		cl_uint deviceCount;
		cl_device_id* devicePtrs;
		
		checkError(clGetDeviceIDs(id, CL_DEVICE_TYPE_ALL, 0, null, &deviceCount), __FILE__, __LINE__);
		if(deviceCount==0) return devices;
		
		devicePtrs = cast(cl_device_id*)malloc(cl_device_id.sizeof * deviceCount);
		checkError(clGetDeviceIDs(id, CL_DEVICE_TYPE_ALL, deviceCount, devicePtrs, &deviceCount), __FILE__, __LINE__);
		for(uint i=0; i<deviceCount; i++) {
			devices ~= new CLDevice(devicePtrs[i]);
		}
		free(devicePtrs);
		return devices;
	}
	/**
	 * For an OpenGL conttext:
     * cl_context_properties[] props = [
     *      CL_GL_CONTEXT_KHR,
     *      gl.getGLContext(),
     *
     *      CL_WGL_HDC_KHR,
     *      gl.getDC()
     *    ];
     */
	CLContext createGPUContext(cl_context_properties[] props) {
        return createContext(getDevices(CL_DEVICE_TYPE_GPU), props);
    }
    CLContext createCPUContext(cl_context_properties[] props) {
        return createContext(getDevices(CL_DEVICE_TYPE_CPU), props);
    }
	CLContext createContext(CLDevice[] devices, cl_context_properties[] props) {
		CLContext c = new CLContext(this, devices, props);
		contexts ~= c;
		return c;
	}
	/**
     *  cl_device_type:
     *      CL_DEVICE_TYPE_CPU
     *      CL_DEVICE_TYPE_GPU
     *      CL_DEVICE_TYPE_ACCELERATOR
     *      CL_DEVICE_TYPE_DEFAULT
     *      CL_DEVICE_TYPE_ALL
     */
    bool canCreateDeviceType(cl_device_type type) {
        cl_context_properties[] props = [
            cast(cl_context_properties)CL_CONTEXT_PLATFORM,
            cast(cl_context_properties)id,
            cast(cl_context_properties)0
        ];
        cl_int err;
        auto ctx = clCreateContextFromType(
            props.ptr,
            type,
            null,
            null,
            &err);
        bool result = err==0;
        if(ctx) clReleaseContext(ctx);
        return result;
    }


	
	override string toString() {
		return ("[Platform %s]"~
                "\n\tvendor  : %s"~
                "\n\tversion : %s"~
                "\n\tprofile : %s"~
                "\n\texts    : %s\n]").format(
            name, vendor, ver, profile, extensions);
	}
}

