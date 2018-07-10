module cl.types;

import cl.all;

struct clint2 {   // 8-byte alignment
    int x,y;
    vec2 toVec2() { return vec2(x,y); }
}
struct clint3 {   // 16-byte alignment
    int x,y,z,padding;
    vec3 toVec3() { return vec3(x,y,z); }
}
struct clint4 {   // 16-byte alignment
    int x,y,z,w;
    vec4 toVec4() { return vec4(x,y,z,w); }
}
struct cluint2 {  // 8-byte alignment
    uint x,y;
    vec2 toVec2() { return vec2(x,y); }
}
struct cluint3 {  // 16-byte alignment
    uint x,y,z,padding;
    vec3 toVec3() { return vec3(x,y,z); }
}
struct cluint4 {  // 16-byte alignment
    uint x,y,z,w;
    vec4 toVec4() { return vec4(x,y,z,w); }
}
struct clfloat2 { // 8-byte alignment
    float x=0,y=0;
    this(vec2 v) {
        x = v.x;
        y = v.y;
    }
    vec2 toVec2() { return vec2(x,y); }
}
struct clfloat3 { // 16-byte alignment
    float x=0,y=0,z=0,padding=0;
    this(vec3 v) {
        x = v.x;
        y = v.y;
        z = v.z;
    }
    vec3 toVec3() { return vec3(x,y,z); }
}
struct clfloat4 { // 16-byte alignment
    float x=0,y=0,z=0,w=0;
    this(vec4 v) {
        x = v.x;
        y = v.y;
        z = v.z;
        w = v.w;
    }
    vec4 toVec4() { return vec4(x,y,z,w); }
}

