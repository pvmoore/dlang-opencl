/**
 *  Sorting example.
 */
#include "common.h"

/**
 *  Passed in by the application:
 *
 *  WORK_GROUP_SIZE = 256
 *  ASCENDING       = true|false
 *
 */

// work_group_scan_inclusive_xxx()   _add(), _min(), _max()
/*
__attribute__((reqd_work_group_size(WORK_GROUP_SIZE, 1, 1)))
//=========================================================
// Crappy version of merge. Slow.
//=========================================================
kernel void merge2(
    global const float* in,
    global float* out,
    const uint chunkSize)
{
    const int tid        = get_global_id(0);
    const int chunkSize2 = chunkSize*2;
    const int chunk      = tid/chunkSize2;
    const bool onLeft    = tid%chunkSize2 < chunkSize;
    const float v        = in[tid];

    global float* a   = in+chunkSize2*chunk;
    global float* b   = a+chunkSize;

    if(onLeft) {
        // find position on right
        int pos;
        for(pos = 0; pos<chunkSize; pos++) {
            if(b[pos]>v) break;
        }
        out[tid+pos] = v;
    } else {
        // find position on left
        int pos;
        for(pos = 0; pos<chunkSize; pos++) {
            if(a[pos]>=v) break;
        }
        out[(tid-chunkSize)+pos] = v;
    }
}*/

#if ASCENDING==true
    #define COMPARE_RT(a,b) (a >= b)
    #define COMPARE_LT(a,b) (a > b)
#else
    #define COMPARE_RT(a,b) (a <= b)
    #define COMPARE_LT(a,b) (a < b)
#endif

int findOnRight(global const float* ptr,
                       const float v,
                       const uint chunkSize)
{
    int left  = 0;
    int right = chunkSize;
    int mid;

    int it = 0;
    do{
        mid = (left+right)/2;
        if(mid==left || mid==right) break;

        float value = ptr[mid];

//        #if ASCENDING==true
//        bool choice = value>=v;
//        #else
//        bool choice = value<=v;
//        #endif
        bool choice = COMPARE_RT(value, v);

        right = choice ? mid : right;   // go left
        left  = choice ? left : mid;    // go right

    }while(true/* && it++<1000*/);

//    #if ASCENDING==true
//        mid += (ptr[mid] < v);
//    #else
      //  mid += (ptr[mid] > v);
//    #endif
    mid += !COMPARE_RT(ptr[mid], v);

    return mid;
}
int findOnLeft(global const float* ptr,
                      const float v,
                      const uint chunkSize)
{
    int left  = 0;
    int right = chunkSize;
    int mid;

    int it = 0;
    do{
        mid = (left+right)/2;
        if(mid==left || mid==right) break;

        float value = ptr[mid];

//        #if ASCENDING==true
//        bool choice = value>v;
//        #else
//        bool choice = value<v;
//        #endif

        bool choice = COMPARE_LT(value, v);

        right = choice ? mid : right;   // go left
        left  = choice ? left : mid;    // go right

    }while(true/* && it++<1000*/);

//    #if ASCENDING==true
//    mid += ptr[mid] <= v;
//    #else
//    mid += ptr[mid] >= v;
//    #endif
    mid += !COMPARE_LT(ptr[mid], v);

    return mid;
}
//================================================================
// Take 2 sorted chunks and merge them together to create a
// larger sorted chunk double the size. Call this as many times
// as required to sort the whole data set.
// 1st iteration: chunkSize will be 256 -> output 512 chunksize
//================================================================
kernel void merge(
    global const float* in,
    global float* out,
    const uint chunkSize)
{
    const int tid        = get_global_id(0);
    const int chunkSize2 = chunkSize*2;
    const int chunk      = tid/chunkSize2;
    const bool onLeft    = tid%chunkSize2 < chunkSize;
    const float v        = in[tid];

    const global float* a   = in+chunkSize2*chunk;
    const global float* b   = a+chunkSize;

    if(onLeft) {
        int pos = findOnRight(b, v, chunkSize);
        out[tid+pos] = v;
    } else {
        int pos = findOnLeft(a, v, chunkSize);
        out[(tid-chunkSize)+pos] = v;
    }
}


//================================================================
//  Just testing. Doesn't work very well and is slow.
//================================================================
/*__attribute__((reqd_work_group_size(WORK_GROUP_SIZE, 1, 1)))
kernel void bitonicSortGlobal(
    global float* in,
    global float* out)
{
    const int i    = get_global_id(0);
    const int size = get_global_size(0);

    // [5,10,1,2,7,3,9,4]

    //  a a  d d a a d d
    // [5,10,2,1,3,7,9,4] length=1

    //  a a a a   d d d d
    // [1,2,5,10, 9,7,4,3] length=2

    //  a a a a a a a a
    // [1,2,3,4, 5,7,9,10] length=4

    // N=4  *(1+2)      comparisons = 12
    // N=8  *(1+2+3)      comparisons = 48
    // N=16 *(1+2+3+4)   comparisons = 160
    // N=32 *(1+2+3+4+5) comparisons = 480
    // N=64 *(1+2+3+4+5+6) comparisons = 1344
    // N=128*(1+2+3+4+5+6+7)   comparisons = 3584
    // N=256*(1+2+3+4+5+6+7+8)   comparisons = 9216

    // if(size==8) -> 1, 2, 4,
    for(int length=1; length<size; length<<=1) {
        // 0=asc, 1=desc
        #if ASCENDING==true
        bool dir = ((i & (length<<1)) != 0);
        #else
        bool dir = ((i & (length<<1)) == 0);
        #endif
        // Loop on comparison distance (between keys)

        // length==1   -> [1]
        // length==2   -> [2,1]
        // length==4   -> [4,2,1]
        for(int inc=length; inc>0; inc>>=1) {
            //             1    2      4      <- length
            // i=0 -> j = [1] [2,1] [4,2,1]
            // i=1 -> j = [0] [3,0] [5,3,0]
            // i=2 -> j = [3] [0,3] [6,0,3]
            // i=3 -> j = [2] [1,2] [7,1,2]
            // i=4 -> j = [5] [6,5] [0,6,5]
            // i=5 -> j = [4] [7,4] [1,7,4]
            // i=6 -> j = [7] [4,7] [2,4,7]
            // i=7 -> j = [6] [5,6] [3,5,6]
            int j = i ^ inc;

            // Load values at I and J
            float iKey = in[i];
            float jKey = in[j];

            // Compare
            bool smaller = (jKey < iKey) || (jKey == iKey && j < i);
            bool swap    = smaller ^ (j < i) ^ dir;

            barrier(CLK_GLOBAL_MEM_FENCE);
            in[i] = (swap) ? jKey : iKey;
            barrier(CLK_GLOBAL_MEM_FENCE);
        }
    }
    out[i] = in[i];
}*/
//================================================================
// Sorts locally only.
//================================================================
/**
 *  Sorts input into length/WORK_GROUP_SIZE sorted arrays
 *  of WORK_GROUP_SIZE floats each.
 *  Both arrays must be a power of 2 in length.
 */
 __attribute__((reqd_work_group_size(WORK_GROUP_SIZE, 1, 1)))
kernel void bitonicSortLocal(
    global float* data)
{
    local float aux[WORK_GROUP_SIZE];
    const int i = get_local_id(0); // index in workgroup

    // Move IN, OUT to block start
    const int offset = get_group_id(0) * WORK_GROUP_SIZE;
    data  += offset;
    //out += offset;

    // Load block in aux[WG]
    aux[i] = data[i];
    barrier(CLK_LOCAL_MEM_FENCE);

    // Loop on sorted sequence length
    //__attribute__((opencl_unroll_hint))
#pragma unroll
    for(int length=1; length<WORK_GROUP_SIZE; length<<=1) {
        // 0=asc, 1=desc
        #if ASCENDING==true
        bool dir = ((i & (length<<1)) != 0);
        #else
        bool dir = ((i & (length<<1)) == 0);
        #endif
        // Loop on comparison distance (between keys)
        for(int inc=length; inc>0; inc>>=1) {
            // sibling to compare
            int j      = i ^ inc;
            float iKey = aux[i];
            float jKey = aux[j];
            bool smaller = (jKey < iKey) || (jKey == iKey && j < i);
            bool swap = smaller ^ (j < i) ^ dir;

            barrier(CLK_LOCAL_MEM_FENCE);
            aux[i] = (swap)?jKey:iKey;
            barrier(CLK_LOCAL_MEM_FENCE);
        }
    }
    // Write output
    data[i] = aux[i];
}
//================================================================
//  Sorts 2* workgroup size = 512
//================================================================
inline void swapLocal(local float *a, local float *b) {
	float tmp = *b;
	*b = *a;
	*a = tmp;
}
// dir == 1 means ascending
inline void sortLocal(local float *a, local float *b, char dir) {
    #if ASCENDING==true
	if((*a > *b) != dir) swapLocal(a, b);
	#else
	if((*a > *b) == dir) swapLocal(a, b);
	#endif
}
/**
 *
 */
 __attribute__((reqd_work_group_size(WORK_GROUP_SIZE, 1, 1)))
kernel void Sort2(
    global const float* inArray,
    global float* outArray)
{
	local float local_buffer[WORK_GROUP_SIZE * 2];
	const uint gid = get_global_id(0);
	const uint lid = get_local_id(0);

	uint index = get_group_id(0) * (WORK_GROUP_SIZE * 2) + lid;
	//load into local mem
	local_buffer[lid] = inArray[index];
	local_buffer[lid + WORK_GROUP_SIZE] = inArray[index + WORK_GROUP_SIZE];

	uint clampedGID = gid & (WORK_GROUP_SIZE - 1);

	// bitonic merge
	for(uint blocksize = 2; blocksize < WORK_GROUP_SIZE * 2; blocksize <<= 1) {
		char dir = (clampedGID & (blocksize / 2)) == 0; // sort every other block in the other direction (faster % calc)
#pragma unroll
		for(uint stride = blocksize >> 1; stride > 0; stride >>= 1){
			barrier(CLK_LOCAL_MEM_FENCE);
			uint idx = 2 * lid - (lid & (stride - 1)); //take every other input BUT starting neighbouring within one block
			sortLocal(&local_buffer[idx], &local_buffer[idx + stride], dir);
		}
	}

	// bitonic merge for biggest group is special (unrolling this so we dont need ifs in the part above)
	char dir = (clampedGID & 0); //even or odd? sort accordingly
#pragma unroll
	for(uint stride = WORK_GROUP_SIZE; stride > 0; stride >>= 1){
		barrier(CLK_LOCAL_MEM_FENCE);
		uint idx = 2 * lid - (lid & (stride - 1));
		sortLocal(&local_buffer[idx], &local_buffer[idx + stride], dir);
	}

	// sync and write back
	barrier(CLK_LOCAL_MEM_FENCE);
	outArray[index] = local_buffer[lid];
	outArray[index + WORK_GROUP_SIZE] = local_buffer[lid + WORK_GROUP_SIZE];
}

