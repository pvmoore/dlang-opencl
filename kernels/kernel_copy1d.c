

kernel void copy1D(global const char* restrict src,
				   global char* restrict dest)
{
    int i = get_global_id(0);

    dest[i] = src[i];
}



