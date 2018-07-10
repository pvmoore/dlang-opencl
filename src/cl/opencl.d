module cl.opencl;
/*
    https://www.khronos.org/registry/cl/
*/
import cl.all;

final class OpenCL {
private:
	CLPlatform[] platforms;
public:
	this() {
		DerelictCL.load();
//		log("Loading OpenCL version %s", version_);
//		DerelictCL.reload(version_);
//        DerelictCL.loadEXT(getPlatform().id);

	}
	void destroy() {
	    log("Destroying OpenCL");
        platforms.each!(it=>it.destroy()); platforms.length = 0;
        DerelictCL.unload();
	}
	/// assumes there is at least one platform and the first
	/// one is the one we want (which may be incorrect)
	CLPlatform getPlatform(cl_device_type type, CLVersion ver) {
	    foreach(p; getPlatforms()) {
            if(p.canCreateDeviceType(type)) return initPlatform(p, ver);
	    }
	    throw new Error("Platform of type %s not found".format(type));
	}
private:
    CLPlatform initPlatform(CLPlatform p, CLVersion ver) {
		DerelictCL.reload(ver);
        DerelictCL.loadEXT(p.id);
        return p;
    }
	CLPlatform[] getPlatforms() {
		if(platforms.length > 0) return platforms;
		
		cl_uint numPlatforms;
	    cl_int errNum;
		
		errNum = clGetPlatformIDs(0, null, &numPlatforms);
	    checkError(errNum, __FILE__, __LINE__);
	    if(numPlatforms==0) return platforms;

	    log("Found %s OpenCL platform(s)", numPlatforms);
	    
	    cl_platform_id* platformData = cast(cl_platform_id*)malloc(numPlatforms * cl_platform_id.sizeof);
	    errNum = clGetPlatformIDs(numPlatforms, platformData, null);
	    checkError(errNum, __FILE__, __LINE__);
	    
	    for(uint i=0; i < numPlatforms; ++i) {
	        auto p = new CLPlatform(platformData[i]);
	    	platforms ~= p;
	    	log("  - %s", p.name);
	    }
	    free(platformData);

		return platforms;
	}
}
