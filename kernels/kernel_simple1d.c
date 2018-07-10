
//#define DEBUG
#include "common.h"
#include "mat4x4.h"

typedef struct PACKED Ray_struct { // 64 bytes
    float3 start;
    float3 position;    // current position
    float3 direction;
    float3 invDirection;
} Ray;

float getMinDistToEdge(const Ray* ray, const uint size) {
    float3 rem  = rem_f3f(ray->position, size);
    float3 dist = ray->direction < 0 ? -rem : size-rem;
    float3 m    = dist * ray->invDirection;
    float res   = min_fff(m.x, m.y, m.z);
    return fmax(res, 0.0f);
    //return fabs(res);
}

kernel void Add(global const float* a,  // 0
				global const float* b,  // 1
                global const uchar* c,  // 2
				global float* d,        // 3
				const uint numElements) // 4
{
	//prefetch(a, 256);
	//prefetch(b, 256);

	// for 1 dim array of 256 (group size 16):
	// i   = 0-255
	// loc = 0-15
	// grp = 0-15
	// for a 2 dim array of 16,16 (group sizes 4,4):
	//
	//
	//
    int i0   = get_global_id(0);
    int i1   = get_global_id(1);
    int loc0 = get_local_id(0);
    int loc1 = get_local_id(1);
	int grp0 = get_group_id(0);
	int grp1 = get_group_id(1);
	int gOffset0 = get_global_offset(0);


	if(i0==0) {
	    #ifdef DEBUG

//        float3 ff = (float3)(1,-1,1);
//
//        float3 rem = (float3)(2,2,2);
//
//        float3 dist = ff < 0 ? -rem : 5-rem;
//
//        printf("dist=%v3f", dist);

        #endif
    }

//    if(i0==0) {
//        float16 f = (float16)(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
//        float f2 = horizontalAdd_f16(f);
//
//        // 136
//
//        printf("HELLO %f", f2);
//    }

    float16 f = *(const global float16*)a;
    float f2  = hadd_f16(f);


    // 0.22848   0.22976

    d[i0] = f2;
}



