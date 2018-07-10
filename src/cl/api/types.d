module cl.api.types;

import cl.all;

extern(Windows) {

struct _cl_platform_id;
struct _cl_device_id;
struct _cl_context;
struct _cl_command_queue;
struct _cl_mem;
struct _cl_program;
struct _cl_kernel;
struct _cl_event;
struct _cl_sampler;

}

//OpenCL Version
//const int CL_VERSION_1_0 = 1;

alias byte 	  cl_char;
alias ubyte   cl_uchar;
alias short   cl_short;
alias ushort  cl_ushort;
alias int     cl_int;
alias uint    cl_uint;
alias long    cl_long;
alias ulong   cl_ulong;
alias ushort  cl_half;
alias float   cl_float;
alias double  cl_double;

alias uint cl_GLuint;
alias int  cl_GLint;
alias uint cl_GLenum;
alias cl_uint     cl_gl_object_type;
alias cl_uint     cl_gl_texture_info;
alias cl_uint     cl_gl_platform_info;
alias cl_uint     cl_gl_context_info;
//alias struct __GLsync* cl_GLsync;

alias cl_uint             cl_bool; /* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. */
alias cl_ulong            cl_bitfield;
alias cl_bitfield         cl_device_type;
alias cl_uint             cl_platform_info;
alias cl_uint             cl_device_info;
alias cl_bitfield         cl_device_address_info;
alias cl_bitfield         cl_device_fp_config;
alias cl_uint             cl_device_mem_cache_type;
alias cl_uint             cl_device_local_mem_type;
alias cl_bitfield         cl_device_exec_capabilities;
alias cl_bitfield         cl_command_queue_properties;

alias ptrdiff_t			cl_context_properties;
alias cl_uint             cl_context_info;
alias cl_uint             cl_command_queue_info;
alias cl_uint             cl_channel_order;
alias cl_uint             cl_channel_type;
alias cl_bitfield         cl_mem_flags;
alias cl_uint             cl_mem_object_type;
alias cl_uint             cl_mem_info;
alias cl_uint             cl_image_info;
alias cl_uint             cl_addressing_mode;
alias cl_uint             cl_filter_mode;
alias cl_uint             cl_sampler_info;
alias cl_bitfield         cl_map_flags;
alias cl_uint             cl_program_info;
alias cl_uint             cl_program_build_info;
alias cl_uint             cl_program_binary_type;
alias cl_int              cl_build_status;
alias cl_uint             cl_kernel_info;
alias cl_uint             cl_kernel_arg_info;
alias cl_uint             cl_kernel_arg_address_qualifier;
alias cl_uint             cl_kernel_arg_access_qualifier;
alias cl_bitfield         cl_kernel_arg_type_qualifier;
alias cl_uint             cl_kernel_work_group_info;
alias cl_uint             cl_event_info;
alias cl_uint             cl_command_type;
alias cl_uint             cl_profiling_info;

struct _cl_image_format {
    cl_channel_order        image_channel_order;
    cl_channel_type         image_channel_data_type;
}
alias _cl_image_format cl_image_format;

alias _cl_platform_id* 	  cl_platform_id;
alias _cl_device_id*      cl_device_id;
alias _cl_context*        cl_context;
alias _cl_command_queue*  cl_command_queue;
alias _cl_mem*            cl_mem;
alias _cl_program*        cl_program;
alias _cl_kernel*         cl_kernel;
alias _cl_event*          cl_event;
alias _cl_sampler*        cl_sampler;

//Error Codes
// https://streamcomputing.eu/blog/2013-04-28/opencl-error-codes/
enum ErrorCode : cl_int {
	CL_SUCCESS =                                 0,
	CL_DEVICE_NOT_FOUND =                        -1,
	CL_DEVICE_NOT_AVAILABLE =                    -2,
	CL_COMPILER_NOT_AVAILABLE =                  -3,
	CL_MEM_OBJECT_ALLOCATION_FAILURE =           -4,
	CL_OUT_OF_RESOURCES =                        -5,
	CL_OUT_OF_HOST_MEMORY =                      -6,
	CL_PROFILING_INFO_NOT_AVAILABLE =            -7,
	CL_MEM_COPY_OVERLAP =                        -8,
	CL_IMAGE_FORMAT_MISMATCH =                   -9,
	CL_IMAGE_FORMAT_NOT_SUPPORTED =              -10,
	CL_BUILD_PROGRAM_FAILURE =                   -11,
	CL_MAP_FAILURE =                             -12,
	CL_INVALID_VALUE =                           -30,
	CL_INVALID_DEVICE_TYPE =                     -31,
	CL_INVALID_PLATFORM =                        -32,
	CL_INVALID_DEVICE =                          -33,
	CL_INVALID_CONTEXT =                         -34,
	CL_INVALID_QUEUE_PROPERTIES =                -35,
	CL_INVALID_COMMAND_QUEUE =                   -36,
	CL_INVALID_HOST_PTR =                        -37,
	CL_INVALID_MEM_OBJECT =                      -38,
	CL_INVALID_IMAGE_FORMAT_DESCRIPTOR =         -39,
	CL_INVALID_IMAGE_SIZE =                      -40,
	CL_INVALID_SAMPLER =                         -41,
	CL_INVALID_BINARY =                          -42,
	CL_INVALID_BUILD_OPTIONS =                   -43,
	CL_INVALID_PROGRAM =                         -44,
	CL_INVALID_PROGRAM_EXECUTABLE =              -45,
	CL_INVALID_KERNEL_NAME =                     -46,
	CL_INVALID_KERNEL_DEFINITION =               -47,
	CL_INVALID_KERNEL =                          -48,
	CL_INVALID_ARG_INDEX =                       -49,
	CL_INVALID_ARG_VALUE =                       -50,
	CL_INVALID_ARG_SIZE =                        -51,
	CL_INVALID_KERNEL_ARGS =                     -52,
	CL_INVALID_WORK_DIMENSION =                  -53,
	CL_INVALID_WORK_GROUP_SIZE =                 -54,
	CL_INVALID_WORK_ITEM_SIZE =                  -55,
	CL_INVALID_GLOBAL_OFFSET =                   -56,
	CL_INVALID_EVENT_WAIT_LIST =                 -57,
	CL_INVALID_EVENT =                           -58,
	CL_INVALID_OPERATION =                       -59,
	CL_INVALID_GL_OBJECT =                       -60,
	CL_INVALID_BUFFER_SIZE =                     -61,
	CL_INVALID_MIP_LEVEL =                       -62,
	CL_INVALID_GLOBAL_WORK_SIZE                 = -63,
    CL_INVALID_PROPERTY                         = -64,
    CL_INVALID_IMAGE_DESCRIPTOR                 = -65,
    CL_INVALID_COMPILER_OPTIONS                 = -66,
    CL_INVALID_LINKER_OPTIONS                   = -67,
    CL_INVALID_DEVICE_PARTITION_COUNT           = -68
}

// cl_bool
const cl_bool CL_FALSE = 0;
const cl_bool CL_TRUE  = 1;

// cl_platform_info
const cl_platform_info CL_PLATFORM_PROFILE =           0x0900;
const cl_platform_info CL_PLATFORM_VERSION =           0x0901;
const cl_platform_info CL_PLATFORM_NAME =              0x0902;
const cl_platform_info CL_PLATFORM_VENDOR =            0x0903;
const cl_platform_info CL_PLATFORM_EXTENSIONS =        0x0904;

// cl_device_type - bitfield
const cl_device_type CL_DEVICE_TYPE_DEFAULT =          cast(cl_device_type)(1 << 0);
const cl_device_type CL_DEVICE_TYPE_CPU =              cast(cl_device_type)(1 << 1);
const cl_device_type CL_DEVICE_TYPE_GPU =              cast(cl_device_type)(1 << 2);
const cl_device_type CL_DEVICE_TYPE_ACCELERATOR =      cast(cl_device_type)(1 << 3);
const cl_device_type CL_DEVICE_TYPE_ALL =              cast(cl_device_type)0xFFFFFFFF;

// cl_device_info
const cl_device_info CL_DEVICE_TYPE =                             0x1000;
const cl_device_info CL_DEVICE_VENDOR_ID =                        0x1001;
const cl_device_info CL_DEVICE_MAX_COMPUTE_UNITS =                0x1002;
const cl_device_info CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS =         0x1003;
const cl_device_info CL_DEVICE_MAX_WORK_GROUP_SIZE =              0x1004;
const cl_device_info CL_DEVICE_MAX_WORK_ITEM_SIZES =              0x1005;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR =      0x1006;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT =     0x1007;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT =       0x1008;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG =      0x1009;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT =     0x100A;
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE =    0x100B;
const cl_device_info CL_DEVICE_MAX_CLOCK_FREQUENCY =              0x100C;
const cl_device_info CL_DEVICE_ADDRESS_BITS =                     0x100D;
const cl_device_info CL_DEVICE_MAX_READ_IMAGE_ARGS =              0x100E;
const cl_device_info CL_DEVICE_MAX_WRITE_IMAGE_ARGS =             0x100F;
const cl_device_info CL_DEVICE_MAX_MEM_ALLOC_SIZE =               0x1010;
const cl_device_info CL_DEVICE_IMAGE2D_MAX_WIDTH =                0x1011;
const cl_device_info CL_DEVICE_IMAGE2D_MAX_HEIGHT =               0x1012;
const cl_device_info CL_DEVICE_IMAGE3D_MAX_WIDTH =                0x1013;
const cl_device_info CL_DEVICE_IMAGE3D_MAX_HEIGHT =               0x1014;
const cl_device_info CL_DEVICE_IMAGE3D_MAX_DEPTH =                0x1015;
const cl_device_info CL_DEVICE_IMAGE_SUPPORT =                    0x1016;
const cl_device_info CL_DEVICE_MAX_PARAMETER_SIZE =               0x1017;
const cl_device_info CL_DEVICE_MAX_SAMPLERS =                     0x1018;
const cl_device_info CL_DEVICE_MEM_BASE_ADDR_ALIGN =              0x1019;
deprecated // in 1.2
const cl_device_info CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE =         0x101A;
const cl_device_info CL_DEVICE_SINGLE_FP_CONFIG =                 0x101B;
const cl_device_info CL_DEVICE_GLOBAL_MEM_CACHE_TYPE =            0x101C;
const cl_device_info CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE =        0x101D;
const cl_device_info CL_DEVICE_GLOBAL_MEM_CACHE_SIZE =            0x101E;
const cl_device_info CL_DEVICE_GLOBAL_MEM_SIZE =                  0x101F;
const cl_device_info CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE =         0x1020;
const cl_device_info CL_DEVICE_MAX_CONSTANT_ARGS =                0x1021;
const cl_device_info CL_DEVICE_LOCAL_MEM_TYPE =                   0x1022;
const cl_device_info CL_DEVICE_LOCAL_MEM_SIZE =                   0x1023;
const cl_device_info CL_DEVICE_ERROR_CORRECTION_SUPPORT =         0x1024;
const cl_device_info CL_DEVICE_PROFILING_TIMER_RESOLUTION =       0x1025;
const cl_device_info CL_DEVICE_ENDIAN_LITTLE =                    0x1026;
const cl_device_info CL_DEVICE_AVAILABLE =                        0x1027;
const cl_device_info CL_DEVICE_COMPILER_AVAILABLE =               0x1028;
const cl_device_info CL_DEVICE_EXECUTION_CAPABILITIES =           0x1029;
//deprecated // in 2.0
const cl_device_info CL_DEVICE_QUEUE_PROPERTIES =                 0x102A;
const cl_device_info CL_DEVICE_NAME =                             0x102B;
const cl_device_info CL_DEVICE_VENDOR =                           0x102C;
const cl_device_info CL_DRIVER_VERSION =                          0x102D;
const cl_device_info CL_DEVICE_PROFILE =                          0x102E;
const cl_device_info CL_DEVICE_VERSION =                          0x102F;
const cl_device_info CL_DEVICE_EXTENSIONS =                       0x1030;
const cl_device_info CL_DEVICE_PLATFORM =                         0x1031;
const cl_device_info CL_DEVICE_DOUBLE_FP_CONFIG = 0x1032;
// 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG
const cl_device_info CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF       = 0x1034;
const cl_device_info CL_DEVICE_HOST_UNIFIED_MEMORY               = 0x1035;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR          = 0x1036;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT         = 0x1037;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_INT           = 0x1038;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG          = 0x1039;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT         = 0x103A;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE        = 0x103B;
const cl_device_info CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF          = 0x103C;
const cl_device_info CL_DEVICE_OPENCL_C_VERSION                  = 0x103D;
const cl_device_info CL_DEVICE_LINKER_AVAILABLE                  = 0x103E;
const cl_device_info CL_DEVICE_BUILT_IN_KERNELS                  = 0x103F;
const cl_device_info CL_DEVICE_IMAGE_MAX_BUFFER_SIZE             = 0x1040;
const cl_device_info CL_DEVICE_IMAGE_MAX_ARRAY_SIZE              = 0x1041;
const cl_device_info CL_DEVICE_PARENT_DEVICE                     = 0x1042;
const cl_device_info CL_DEVICE_PARTITION_MAX_SUB_DEVICES         = 0x1043;
const cl_device_info CL_DEVICE_PARTITION_PROPERTIES              = 0x1044;
const cl_device_info CL_DEVICE_PARTITION_AFFINITY_DOMAIN         = 0x1045;
const cl_device_info CL_DEVICE_PARTITION_TYPE                    = 0x1046;
const cl_device_info CL_DEVICE_REFERENCE_COUNT                   = 0x1047;
const cl_device_info CL_DEVICE_PREFERRED_INTEROP_USER_SYNC       = 0x1048;
const cl_device_info CL_DEVICE_PRINTF_BUFFER_SIZE                = 0x1049;

// cl_device_fp_config
enum : cl_device_fp_config
{
    CL_FP_DENORM                                = (1 << 0),
    CL_FP_INF_NAN                               = (1 << 1),
    CL_FP_ROUND_TO_NEAREST                      = (1 << 2),
    CL_FP_ROUND_TO_ZERO                         = (1 << 3),
    CL_FP_ROUND_TO_INF                          = (1 << 4),
    CL_FP_FMA                                   = (1 << 5),
    CL_FP_SOFT_FLOAT                            = (1 << 6),
    CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT         = (1 << 7)
}

// cl_device_mem_cache_type
const cl_device_mem_cache_type CL_NONE =                          0x0;
const cl_device_mem_cache_type CL_READ_ONLY_CACHE =               0x1;
const cl_device_mem_cache_type CL_READ_WRITE_CACHE =              0x2;

// cl_device_local_mem_type
const cl_device_local_mem_type CL_LOCAL =                         0x1;
const cl_device_local_mem_type CL_GLOBAL =                        0x2;

// cl_device_exec_capabilities - bitfield
const cl_device_exec_capabilities CL_EXEC_KERNEL =                cast(cl_device_exec_capabilities)(1 << 0);
const cl_device_exec_capabilities CL_EXEC_NATIVE_KERNEL =         cast(cl_device_exec_capabilities)(1 << 1);

// cl_command_queue_properties - bitfield
const cl_command_queue_properties CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE =     cast(cl_command_queue_properties)(1 << 0);
const cl_command_queue_properties CL_QUEUE_PROFILING_ENABLE =                  cast(cl_command_queue_properties)(1 << 1);

// cl_context_info
enum : cl_context_info
{
    CL_CONTEXT_REFERENCE_COUNT                  = 0x1080,
    CL_CONTEXT_DEVICES                          = 0x1081,
    CL_CONTEXT_PROPERTIES                       = 0x1082,
    CL_CONTEXT_NUM_DEVICES                      = 0x1083
}

// cl_context_properties
enum : cl_context_properties
{
    CL_CONTEXT_PLATFORM                         = 0x1084,
    CL_CONTEXT_INTEROP_USER_SYNC                = 0x1085
}

// cl_device_partition_property
enum : ptrdiff_t
{
    CL_DEVICE_PARTITION_EQUALLY                 = 0x1086,
    CL_DEVICE_PARTITION_BY_COUNTS               = 0x1087,
    CL_DEVICE_PARTITION_BY_COUNTS_LIST_END      = 0x0,
    CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN      = 0x1088
}

// cl_device_affinity_domain
enum : cl_bitfield
{
    CL_DEVICE_AFFINITY_DOMAIN_NUMA               = (1 << 0),
    CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE           = (1 << 1),
    CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE           = (1 << 2),
    CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE           = (1 << 3),
    CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE           = (1 << 4),
    CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = (1 << 5)
}

// cl_command_queue_info
const cl_command_queue_info CL_QUEUE_CONTEXT =         0x1090;
const cl_command_queue_info CL_QUEUE_DEVICE =          0x1091;
const cl_command_queue_info CL_QUEUE_REFERENCE_COUNT = 0x1092;
const cl_command_queue_info CL_QUEUE_PROPERTIES =      0x1093;

enum : cl_mem_flags
{
    CL_MEM_READ_WRITE                           = (1 << 0),
    CL_MEM_WRITE_ONLY                           = (1 << 1),
    CL_MEM_READ_ONLY                            = (1 << 2),
    CL_MEM_USE_HOST_PTR                         = (1 << 3),
    CL_MEM_ALLOC_HOST_PTR                       = (1 << 4),
    CL_MEM_COPY_HOST_PTR                        = (1 << 5),
// reserved                                     = (1 << 6),
    CL_MEM_HOST_WRITE_ONLY                      = (1 << 7),
    CL_MEM_HOST_READ_ONLY                       = (1 << 8),
    CL_MEM_HOST_NO_ACCESS                       = (1 << 9)
}

// cl_channel_order
const cl_channel_order CL_R =                          0x10B0;
const cl_channel_order CL_A =                          0x10B1;
const cl_channel_order CL_RG =                         0x10B2;
const cl_channel_order CL_RA =                         0x10B3;
const cl_channel_order CL_RGB =                        0x10B4;
const cl_channel_order CL_RGBA =                       0x10B5;
const cl_channel_order CL_BGRA =                       0x10B6;
const cl_channel_order CL_ARGB =                       0x10B7;
const cl_channel_order CL_INTENSITY =                  0x10B8;
const cl_channel_order CL_LUMINANCE =                  0x10B9;
const cl_channel_order CL_Rx                          = 0x10BA;
const cl_channel_order CL_RGx                         = 0x10BB;
const cl_channel_order CL_RGBx                        = 0x10BC;
const cl_channel_order CL_DEPTH                       = 0x10BD;
const cl_channel_order CL_DEPTH_STENCIL               = 0x10BE;

// cl_channel_type
const cl_channel_type CL_SNORM_INT8 =                              0x10D0;
const cl_channel_type CL_SNORM_INT16 =                             0x10D1;
const cl_channel_type CL_UNORM_INT8 =                              0x10D2;
const cl_channel_type CL_UNORM_INT16 =                             0x10D3;
const cl_channel_type CL_UNORM_SHORT_565 =                         0x10D4;
const cl_channel_type CL_UNORM_SHORT_555 =                         0x10D5;
const cl_channel_type CL_UNORM_INT_101010 =                        0x10D6;
const cl_channel_type CL_SIGNED_INT8 =                             0x10D7;
const cl_channel_type CL_SIGNED_INT16 =                            0x10D8;
const cl_channel_type CL_SIGNED_INT32 =                            0x10D9;
const cl_channel_type CL_UNSIGNED_INT8 =                           0x10DA;
const cl_channel_type CL_UNSIGNED_INT16 =                          0x10DB;
const cl_channel_type CL_UNSIGNED_INT32 =                          0x10DC;
const cl_channel_type CL_HALF_FLOAT =                              0x10DD;
const cl_channel_type CL_FLOAT =                                   0x10DE;
const cl_channel_type CL_UNORM_INT24                             = 0x10DF;

// cl_mem_object_type
const cl_mem_object_type CL_MEM_OBJECT_BUFFER =                       0x10F0;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE2D =                      0x10F1;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE3D =                      0x10F2;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE2D_ARRAY                 = 0x10F3;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE1D                       = 0x10F4;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE1D_ARRAY                 = 0x10F5;
const cl_mem_object_type CL_MEM_OBJECT_IMAGE1D_BUFFER                = 0x10F6;

// cl_mem_info
const cl_mem_info CL_MEM_TYPE =                                0x1100;
const cl_mem_info CL_MEM_FLAGS =                               0x1101;
const cl_mem_info CL_MEM_SIZE =                                0x1102;
const cl_mem_info CL_MEM_HOST_PTR =                            0x1103;
const cl_mem_info CL_MEM_MAP_COUNT =                           0x1104;
const cl_mem_info CL_MEM_REFERENCE_COUNT =                     0x1105;
const cl_mem_info CL_MEM_CONTEXT =                             0x1106;
const cl_mem_info CL_MEM_ASSOCIATED_MEMOBJECT                 = 0x1107;
const cl_mem_info CL_MEM_OFFSET                               = 0x1108;

// cl_image_info
const cl_image_info CL_IMAGE_FORMAT =                            0x1110;
const cl_image_info CL_IMAGE_ELEMENT_SIZE =                      0x1111;
const cl_image_info CL_IMAGE_ROW_PITCH =                         0x1112;
const cl_image_info CL_IMAGE_SLICE_PITCH =                       0x1113;
const cl_image_info CL_IMAGE_WIDTH =                             0x1114;
const cl_image_info CL_IMAGE_HEIGHT =                            0x1115;
const cl_image_info CL_IMAGE_DEPTH =                             0x1116;
const cl_image_info CL_IMAGE_ARRAY_SIZE                         = 0x1117;
const cl_image_info CL_IMAGE_BUFFER                             = 0x1118;
const cl_image_info CL_IMAGE_NUM_MIP_LEVELS                     = 0x1119;
const cl_image_info CL_IMAGE_NUM_SAMPLES                        = 0x111A;

// cl_addressing_mode
const cl_addressing_mode CL_ADDRESS_NONE =                            0x1130;
const cl_addressing_mode CL_ADDRESS_CLAMP_TO_EDGE =                   0x1131;
const cl_addressing_mode CL_ADDRESS_CLAMP =                           0x1132;
const cl_addressing_mode CL_ADDRESS_REPEAT =                          0x1133;
const cl_addressing_mode CL_ADDRESS_MIRRORED_REPEAT                 = 0x1134;

// cl_filter_mode
const cl_filter_mode CL_FILTER_NEAREST =                          0x1140;
const cl_filter_mode CL_FILTER_LINEAR =                           0x1141;

// cl_sampler_info
const cl_sampler_info CL_SAMPLER_REFERENCE_COUNT =                 0x1150;
const cl_sampler_info CL_SAMPLER_CONTEXT =                         0x1151;
const cl_sampler_info CL_SAMPLER_NORMALIZED_COORDS =               0x1152;
const cl_sampler_info CL_SAMPLER_ADDRESSING_MODE =                 0x1153;
const cl_sampler_info CL_SAMPLER_FILTER_MODE =                     0x1154;

// cl_map_flags - bitfield
const cl_map_flags CL_MAP_READ =                                cast(cl_map_flags)(1 << 0);
const cl_map_flags CL_MAP_WRITE =                               cast(cl_map_flags)(1 << 1);
const cl_map_flags CL_MAP_WRITE_INVALIDATE_REGION            = cast(cl_map_flags)(1 << 2);

// cl_program_info
const cl_program_info CL_PROGRAM_REFERENCE_COUNT =                 0x1160;
const cl_program_info CL_PROGRAM_CONTEXT =                         0x1161;
const cl_program_info CL_PROGRAM_NUM_DEVICES =                     0x1162;
const cl_program_info CL_PROGRAM_DEVICES =                         0x1163;
const cl_program_info CL_PROGRAM_SOURCE =                          0x1164;
const cl_program_info CL_PROGRAM_BINARY_SIZES =                    0x1165;
const cl_program_info CL_PROGRAM_BINARIES =                        0x1166;
const cl_program_info CL_PROGRAM_NUM_KERNELS                      = 0x1167;
const cl_program_info CL_PROGRAM_KERNEL_NAMES                     = 0x1168;

// cl_program_build_info
const cl_program_build_info CL_PROGRAM_BUILD_STATUS =               0x1181;
const cl_program_build_info CL_PROGRAM_BUILD_OPTIONS =              0x1182;
const cl_program_build_info CL_PROGRAM_BUILD_LOG =                  0x1183;
const cl_program_build_info CL_PROGRAM_BINARY_TYPE =                0x1184;

// cl_program_binary_type
enum : cl_program_binary_type {
    CL_PROGRAM_BINARY_TYPE_NONE                 = 0x0,
    CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT      = 0x1,
    CL_PROGRAM_BINARY_TYPE_LIBRARY              = 0x2,
    CL_PROGRAM_BINARY_TYPE_EXECUTABLE           = 0x4
}

// cl_build_status
const cl_build_status CL_BUILD_SUCCESS =                           0;
const cl_build_status CL_BUILD_NONE =                              -1;
const cl_build_status CL_BUILD_ERROR =                             -2;
const cl_build_status CL_BUILD_IN_PROGRESS =                       -3;

// cl_kernel_info
enum : cl_kernel_info {
    CL_KERNEL_FUNCTION_NAME   = 0x1190,
    CL_KERNEL_NUM_ARGS        = 0x1191,
    CL_KERNEL_REFERENCE_COUNT = 0x1192,
    CL_KERNEL_CONTEXT         = 0x1193,
    CL_KERNEL_PROGRAM         = 0x1194,
    CL_KERNEL_ATTRIBUTES      = 0x1195
}

// cl_kernel_arg_info
enum : cl_kernel_arg_info {
    CL_KERNEL_ARG_ADDRESS_QUALIFIER             = 0x1196,
    CL_KERNEL_ARG_ACCESS_QUALIFIER              = 0x1197,
    CL_KERNEL_ARG_TYPE_NAME                     = 0x1198,
    CL_KERNEL_ARG_TYPE_QUALIFIER                = 0x1199,
    CL_KERNEL_ARG_NAME                          = 0x119A
}

// cl_kernel_arg_address_qualifier
enum : cl_kernel_arg_address_qualifier
{
    CL_KERNEL_ARG_ADDRESS_GLOBAL                = 0x119B,
    CL_KERNEL_ARG_ADDRESS_LOCAL                 = 0x119C,
    CL_KERNEL_ARG_ADDRESS_CONSTANT              = 0x119D,
    CL_KERNEL_ARG_ADDRESS_PRIVATE               = 0x119E
}

// cl_kernel_arg_access_qualifier
enum : cl_kernel_arg_access_qualifier
{
    CL_KERNEL_ARG_ACCESS_READ_ONLY              = 0x11A0,
    CL_KERNEL_ARG_ACCESS_WRITE_ONLY             = 0x11A1,
    CL_KERNEL_ARG_ACCESS_READ_WRITE             = 0x11A2,
    CL_KERNEL_ARG_ACCESS_NONE                   = 0x11A3
}

// cl_kernel_arg_type_qualifier
enum : cl_kernel_arg_type_qualifier
{
    CL_KERNEL_ARG_TYPE_NONE                     = 0,
    CL_KERNEL_ARG_TYPE_CONST                    = (1 << 0),
    CL_KERNEL_ARG_TYPE_RESTRICT                 = (1 << 1),
    CL_KERNEL_ARG_TYPE_VOLATILE                 = (1 << 2)
}

// cl_kernel_work_group_info
enum : cl_kernel_work_group_info
{
    CL_KERNEL_WORK_GROUP_SIZE                   = 0x11B0,
    CL_KERNEL_COMPILE_WORK_GROUP_SIZE           = 0x11B1,
    CL_KERNEL_LOCAL_MEM_SIZE                    = 0x11B2,
    CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE= 0x11B3,
    CL_KERNEL_PRIVATE_MEM_SIZE                  = 0x11B4,
    CL_KERNEL_GLOBAL_WORK_SIZE                  = 0x11B5
}

// cl_event_info
enum : cl_event_info
{
    CL_EVENT_COMMAND_QUEUE                      = 0x11D0,
    CL_EVENT_COMMAND_TYPE                       = 0x11D1,
    CL_EVENT_REFERENCE_COUNT                    = 0x11D2,
    CL_EVENT_COMMAND_EXECUTION_STATUS           = 0x11D3,
    CL_EVENT_CONTEXT                            = 0x11D4
}

// cl_command_type
enum : cl_command_type
{
    CL_COMMAND_NDRANGE_KERNEL                   = 0x11F0,
    CL_COMMAND_TASK                             = 0x11F1,
    CL_COMMAND_NATIVE_KERNEL                    = 0x11F2,
    CL_COMMAND_READ_BUFFER                      = 0x11F3,
    CL_COMMAND_WRITE_BUFFER                     = 0x11F4,
    CL_COMMAND_COPY_BUFFER                      = 0x11F5,
    CL_COMMAND_READ_IMAGE                       = 0x11F6,
    CL_COMMAND_WRITE_IMAGE                      = 0x11F7,
    CL_COMMAND_COPY_IMAGE                       = 0x11F8,
    CL_COMMAND_COPY_IMAGE_TO_BUFFER             = 0x11F9,
    CL_COMMAND_COPY_BUFFER_TO_IMAGE             = 0x11FA,
    CL_COMMAND_MAP_BUFFER                       = 0x11FB,
    CL_COMMAND_MAP_IMAGE                        = 0x11FC,
    CL_COMMAND_UNMAP_MEM_OBJECT                 = 0x11FD,
    CL_COMMAND_MARKER                           = 0x11FE,
    CL_COMMAND_ACQUIRE_GL_OBJECTS               = 0x11FF,
    CL_COMMAND_RELEASE_GL_OBJECTS               = 0x1200,
    CL_COMMAND_READ_BUFFER_RECT                 = 0x1201,
    CL_COMMAND_WRITE_BUFFER_RECT                = 0x1202,
    CL_COMMAND_COPY_BUFFER_RECT                 = 0x1203,
    CL_COMMAND_USER                             = 0x1204,
    CL_COMMAND_BARRIER                          = 0x1205,
    CL_COMMAND_MIGRATE_MEM_OBJECTS              = 0x1206,
    CL_COMMAND_FILL_BUFFER                      = 0x1207,
    CL_COMMAND_FILL_IMAGE                       = 0x1208
}

// cl_command_execution_status
enum
{
    CL_COMPLETE                                 = 0x0,
    CL_RUNNING                                  = 0x1,
    CL_SUBMITTED                                = 0x2,
    CL_QUEUED                                   = 0x3
}

// cl_buffer_create_type
enum
{
    CL_BUFFER_CREATE_TYPE_REGION                = 0x1220
}

// cl_profiling_info
enum : uint
{
    CL_PROFILING_COMMAND_QUEUED                 = 0x1280,
    CL_PROFILING_COMMAND_SUBMIT                 = 0x1281,
    CL_PROFILING_COMMAND_START                  = 0x1282,
    CL_PROFILING_COMMAND_END                    = 0x1283
}