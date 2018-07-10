module cl.utils.mem_mapping;
/**
 *  Manage a region of host memory for
 *  use as data trasfer between host and device.
 */
import cl.all;

enum MMFlags : ulong {
    GPU_READ       = CL_MEM_READ_ONLY,
    GPU_WRITE      = CL_MEM_WRITE_ONLY,
    GPU_READ_WRITE = CL_MEM_READ_WRITE
}

final class CLMemMapping(T) {
private:
    CLCommandQueue queue;
    ulong num;
    MMFlags flags;
    T[] data;
public:
    CLBuffer buffer;
    ulong size;

    T* ptr() { return data.ptr; }

    this(CLContext context,
         CLCommandQueue queue,
         MMFlags flags,
         ulong numTs)
    {
        this.queue  = queue;
        this.flags  = flags;
        this.num    = numTs;
        this.data   = new T[numTs];
        this.size   = T.sizeof*numTs;
        this.buffer = context.createBuffer(
            cast(ulong)flags | CL_MEM_USE_HOST_PTR,
            size,
            data.ptr
        );
    }
    T* mapForHostRead(bool block, ulong tOffset=0, ulong numTs=0) {
        expect(flags==MMFlags.GPU_WRITE || flags==MMFlags.GPU_READ_WRITE);
        auto numBytes = (numTs==0 ? num : numTs) * T.sizeof;
        auto offset   = tOffset * T.sizeof;
        T* ptr = cast(T*)queue.enqueueMapBuffer(
            buffer,
            offset,
            numBytes,
            CL_MAP_WRITE,
            null,
            block
        );
        return ptr;
    }
    T* mapForHostWrite(bool block, ulong tOffset=0, ulong numTs=0) {
        expect(flags==MMFlags.GPU_READ || flags==MMFlags.GPU_READ_WRITE);
        auto numBytes = (numTs==0 ? num : numTs) * T.sizeof;
        auto offset   = tOffset * T.sizeof;
        T* ptr = cast(T*)queue.enqueueMapBuffer(
            buffer,
            offset,
            numBytes,
            CL_MAP_READ,
            null,
            block
        );
        return ptr;
    }
    void unmap(void* ptr) {
        queue.enqueueUnmapMemObject(buffer, ptr);
    }
}

