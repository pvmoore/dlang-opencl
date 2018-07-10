module cl.util;

import cl.all;

bool toBool(cl_bool b) pure nothrow {
    return b==CL_TRUE;
}
cl_bool toCLBool(bool b) pure nothrow {
    return b ? CL_TRUE : CL_FALSE;
}

void checkError(cl_int err) {
	checkError(err, "UNKNOWN", -1);
}

void checkError(cl_int err, string file, long line) {
	if(err) {
		string msg;
		switch(err) {
		    case -4  : msg = "CL_MEM_OBJECT_ALLOCATION_FAILURE"; break;
		    case -5  : msg = "CL_OUT_OF_RESOURCES"; break;
		    case -6  : msg = "CL_OUT_OF_HOST_MEMORY"; break;
		    case -7  : msg = "CL_PROFILING_INFO_NOT_AVAILABLE"; break;
		    case -8  : msg = "CL_MEM_COPY_OVERLAP"; break;
		    case -11 : msg = "CL_BUILD_PROGRAM_FAILURE"; break;
		    case -12 : msg = "CL_MAP_FAILURE"; break;
		    case -14 : msg = "CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST"; break;
		    case -30 : msg = "CL_INVALID_VALUE"; break;
		    case -34 : msg = "CL_INVALID_CONTEXT"; break;
		    case -37 : msg = "CL_INVALID_HOST_PTR"; break;
		    case -40 : msg = "CL_INVALID_IMAGE_SIZE"; break;
		    case -43 : msg = "CL_INVALID_BUILD_OPTIONS"; break;
		    case -48 : msg = "CL_INVALID_KERNEL"; break;
		    case -50 : msg = "CL_INVALID_ARG_VALUE"; break;
		    case -51 : msg = "CL_INVALID_ARG_SIZE"; break;
		    case -52 : msg = "CL_INVALID_KERNEL_ARGS"; break;
		    case -54 : msg = "CL_INVALID_WORK_GROUP_SIZE"; break;
			case -58 : msg = "CL_INVALID_EVENT"; break;
			case -59 : msg = "CL_INVALID_OPERATION"; break;
			case -60 : msg = "CL_INVALID_GL_OBJECT"; break;
			default: msg = "UNKNOWN"; break;
		}
		writefln("OpenCL error in file '%s' at line %s: %s (%s)",
        		    file, line, msg, err);
        flushConsole();
		assert(false);
	}
}

