module cl.event;

import cl.all;

void await(cl_event event) {
    checkError(clWaitForEvents(1, &event), __FILE__, __LINE__);
}
uint getReferenceCount(cl_event e) {
    uint value;
    int err = clGetEventInfo(
        e,
        CL_EVENT_REFERENCE_COUNT,
        uint.sizeof,
        &value,
        null
    );
    return value;
}
void release(cl_event e) {
    checkError(clReleaseEvent(e), __FILE__, __LINE__);
}
void releaseAll(cl_event e) {
    uint refCount = e.getReferenceCount;
    for(auto i=0;i<refCount;i++) {
        checkError(clReleaseEvent(e), __FILE__, __LINE__);
    }
}
void retain(cl_event e) {
    checkError(clRetainEvent(e), __FILE__, __LINE__);
}
ulong getRunTime(cl_event event) {
    //event.await();
    ulong start, end;
    checkError(clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, cl_ulong.sizeof, &start, null), __FILE__, __LINE__);
    checkError(clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, cl_ulong.sizeof, &end, null), __FILE__, __LINE__);
    return end-start;
}
ulong getQueuedTime(cl_event event) {
    //event.await();
    ulong start, end;
    checkError(clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_QUEUED, cl_ulong.sizeof, &start, null), __FILE__, __LINE__);
    checkError(clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, cl_ulong.sizeof, &end, null), __FILE__, __LINE__);
    return end-start;
}
ulong getTimeOf(cl_event e, cl_profiling_info param) {
    ulong value;
    clGetEventProfilingInfo(e, param, ulong.sizeof, &value, null);
    return value;
}
cl_event createUserEvent(CLContext ctx) {
    int err;
    cl_event evt = clCreateUserEvent(ctx.id, &err);
    checkError(err, __FILE__, __LINE__);
    return evt;
}
/// status: CL_COMPLETE or a negative error value
void setStatus(cl_event e, int status) {
    checkError(clSetUserEventStatus (e, status), __FILE__, __LINE__);
}
/// CL_QUEUED, CL_SUBMITTED, CL_RUNNING, CL_COMPLETE
/// or a negative error code
int getStatus(cl_event e) {
    int value;
    int err = clGetEventInfo(
        e,
        CL_EVENT_COMMAND_EXECUTION_STATUS,
        int.sizeof,
        &value,
        null
    );
    checkError(err, __FILE__, __LINE__);
    return value;
}

