module cl.program;

import cl.all;

final class CLProgram {
private:
    CLContext context;
	CLDevice device;
	cl_program programId;
	string filename;
	CLKernel[] kernels;
	bool _compiled;
	string _compilationMessage;
public:
    cl_program id() { return programId; }
    bool compiled() { return _compiled; }
    string compilationMessage() { return _compilationMessage; }
    string getFilename() { return filename; }

    /**
     * options eg. ["-D key", "-D key2=value2", "-I dir"]
     */
	this(CLContext context, CLDevice device, string filename,
         string[] options, bool warningsAsErrors=true)
    {
		this.context  = context;
		this.device   = device;
		this.filename = filename;
		
		char[] src = cast(char[])read(filename);
		//writefln("src = %s", src);
		//writefln("creating program");flushStdErrOut();
		
		size_t len = src.length;
		char* p = src.ptr;
		cl_int errNum;
		programId = clCreateProgramWithSource(
		    context.id,
		    1,
		    cast(char**)&p,
		    &len,
		    &errNum
		);
		checkError(errNum);
		//writefln("program created %s", programId); flushStdErrOut();

        if(warningsAsErrors) {
            options ~= "-Werror";
        }

		string optionsStr =
            //"-Werror "~ 			            // Make all warnings into errors
            //"-w"~                              // inhibit all warnings

            "-cl-single-precision-constant "~ 	// Treat double precision floating-point constant as single precision constant
            "-cl-fast-relaxed-math "~ 			// Enable all unsafe maths optimisations
            "-cl-mad-enable "~
            "-cl-no-signed-zeros "~
            "-cl-denorms-are-zero "~

            //"-cl-uniform-work-group-size "~ // 2.0 - requires that the global work-size be a multiple of the work-group size
            "-I kernels/ "~
            "-I c:/pvmoore/_assets/kernels/ "~
            //"-O5 "~
            //"-cl-std=CL2.0 "~ // 2.0
            options.join(" ");

        writefln("building program with options %s", optionsStr);
		errNum = clBuildProgram(
		    programId,
		    0,          // num devices
		    null,       // devices
		    optionsStr.toStringz,
		    null,       // callback
		    null        // user data
		);
		//writefln("finished building program: %s", errNum); flushStdErrOut();
		//cl_build_status status;
		//clGetProgramBuildInfo(programId, context.getDeviceId(), CL_PROGRAM_BUILD_STATUS, cl_build_status.sizeof, &status, null);
		//writefln("Build status: %s", status); flushStdErrOut();
		
		if(errNum) {
		    ulong sizeGiven;
			char[10240] cBuildLog;
		    clGetProgramBuildInfo(programId, device.id, CL_PROGRAM_BUILD_LOG, cBuildLog.sizeof, cBuildLog.ptr, &sizeGiven);

		    _compilationMessage = cast(string)cBuildLog[0..sizeGiven].dup;
		    writefln("\nOpenCL build log: "~ _compilationMessage);
		    flushConsole();
		}
		_compiled = errNum==CL_SUCCESS;
	}
	void destroy() {
	    kernels.each!(it=>it.destroy()); kernels.length = 0;
    	if(programId) clReleaseProgram(programId); programId = null;
	}

	CLKernel getKernel(string funcName) {
		for(int i=0; i<kernels.length; i++) {
			if(funcName==kernels[i].name) return kernels[i];
		}
		auto k = new CLKernel(this, funcName);
		kernels ~= k;
		return k;
	}
}