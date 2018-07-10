/**
 *  This is an example of enqueuing another kernel
 *  from within a kernel. This requires OpenCL 2.0
 */
kernel void child(global const float* input,
                  global float* output)
{
    const uint i = get_global_id(0);

    printf("child %u", i);

    //output[i] = input[i];
}

kernel void compute(global const float* input,
                    global float* output)
{
	const uint i = get_global_id(0);
//  printf(\"hello %.2f %.2f\\n\", a[i], b[i]);

    printf("parent %u", i);

    if(i==0) {
        ndrange_t range = ndrange_1D(3);
        queue_t queue   = get_default_queue();
        // CLK_ENQUEUE_FLAGS_NO_WAIT
        // CLK_ENQUEUE_FLAGS_WAIT_KERNEL
        // CLK_ENQUEUE_FLAGS_WAIT_WORK_GROUP
        kernel_enqueue_flags_t flags =
            CLK_ENQUEUE_FLAGS_WAIT_KERNEL;

        enqueue_kernel(
            queue,
            flags,
            range,
            ^{child(input, output);}
        );
    }

    // new work-group functions:

    // work_group_broadcast()
    // work_group_reduce_xxx()  _add(), _min(), _max()
    // work_group_all()
    // work_group_any()
    // work_group_scan_inclusive_xxx()   _add(), _min(), _max()
    // work_group_scan_exclusive_xxx()   _add(), _min(), _max()


	output[i] = input[i];
}

