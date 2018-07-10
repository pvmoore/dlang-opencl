
#include "common.h"

kernel void Transfer(global const uchar* input,
					 global uchar* output,
					 uint numInputs)
{
    int i = get_global_id(0);
    int l = get_local_id(0);

	if(i==0) {
	   
	}
	
	output[i] = input[i];
}



