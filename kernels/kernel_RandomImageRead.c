
#include "common.h"

const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | 
					      CLK_ADDRESS_NONE | 
					      CLK_FILTER_NEAREST;

kernel void RandomImageRead(global const uchar* input,
                            image2d_t image,
                            global uchar* output,
                            uint numInputs)
{
    int i     = get_global_id(0);
    int l     = get_local_id(0);
    int width = get_image_width(image);

	if(i==0) {
	   
	}
	
	// random access read
	uint index = (uint)(rand(i, l) * numInputs);
	uint y     = index/width;
	uint x     = index - (y*width);
	uint4 v    = read_imageui(image, sampler, (float2)(x,y));
	output[i]  = v.x;
	//output[i] = input[index];
}



