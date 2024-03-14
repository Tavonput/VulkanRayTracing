struct GlobalUniform
{
	mat4 viewProjection;
	mat4 viewInverse;
	mat4 projInverse;

	vec3 viewPosition;
	float lightIntensity;

	vec3 lightPosition;
	vec3 lightColor;
};

struct ObjectDescription
{
	uint64_t vertexAddress;
	uint64_t indexAddress;
	uint64_t materialAddress;
	uint64_t materialIndexAddress;
};

struct Vertex
{
	vec3 pos;
	vec3 color;
	vec3 normal;
	vec2 texCoord;
};

struct Material
{
	vec3    ambient;
	float   shininess;

	vec3    diffuse;
	float   ior;

	vec3    specular;
	float   dissolve;

	vec3    transmittance;
	int     illum;

	vec3    emission;
	int     textureID;
};

struct PushConstant
{
	mat4 model;
	vec3 objectColor;
	int  objectID;
};

struct RtxPushConstant
{
	vec4 clearColor;

	int maxDepth;
	int sampleCount;

	int frame;
};

struct hitPayload
{
	vec3 hitValue;
	int  depth;
	vec3 attenuation;
	int  done;
	vec3 rayOrigin;
	vec3 rayDir;
};
