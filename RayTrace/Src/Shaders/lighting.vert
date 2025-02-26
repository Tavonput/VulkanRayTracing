#version 460

#extension GL_GOOGLE_include_directive : enable
#extension GL_ARB_gpu_shader_int64 : require

#include "structures.glsl"
#include "random.glsl"

// Input
layout (location = 0) in vec3 inPosition;
layout (location = 1) in vec3 inColor;
layout (location = 2) in vec3 inNormal;
layout (location = 3) in vec3 inTangent;
layout (location = 4) in vec2 inTexCoord;

// Output
layout (location = 0) out vec3 fragNormal;
layout (location = 1) out vec3 fragPos;
layout (location = 2) out vec2 texCoords;
layout (location = 3) out mat3 TBN;

// Global uniform
layout (binding = 0) uniform _GlobalUniform{ GlobalUniform uni; };

// Push Constant
layout (push_constant) uniform Constants { PushConstant pc; };

void main()
{
	vec4 worldPosFull = pc.model * vec4(inPosition, 1.0);

	fragPos     = vec3(worldPosFull);
	gl_Position = uni.viewProjection * worldPosFull;

	texCoords  = inTexCoord;
	
	mat3 normalMatrix = mat3(transpose(inverse(pc.model)));

	vec3 N = normalize(normalMatrix * inNormal);
	vec3 T = normalize(normalMatrix * inTangent);
	T      = normalize(T - dot(T, N) * N);
	vec3 B = cross(N, T);
	
	fragNormal = N;

	TBN = mat3(T, B, N);
}
