module cl.buffer;

import cl.all;

interface MemObject {
    void destroy();
}

final class CLBuffer : MemObject {
	cl_mem id;
	cl_mem_flags flags;
	size_t size;

	this(cl_mem id, cl_mem_flags flags, size_t numBytes) {
		this.id     = id;
		this.flags  = flags;
		this.size   = numBytes;
	}
	void destroy() {
	    if(id) clReleaseMemObject(id); id = null;
	}
}
final class Image : MemObject {
    cl_mem id;
    cl_mem_flags flags;
    uint width, height;
    this(cl_mem id, cl_mem_flags flags, uint width, uint height) {
        this.id     = id;
        this.flags  = flags;
        this.width  = width;
        this.height = height;
    }
    void destroy() {
        if(id) clReleaseMemObject(id); id = null;
    }
}