#version 300 es

precision mediump float;

/* Lecture 21
 * CSCI 4611, Fall 2022, University of Minnesota
 * Instructor: Evan Suma Rosenberg <suma@umn.edu>
 * License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
 */ 

// The shader will be identical to the unlit shader in GopherGfx.

#define POINT_LIGHT 0
#define DIRECTIONAL_LIGHT 1

const int MAX_LIGHTS = 8;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 normalMatrix;

uniform vec3 kAmbient;
uniform vec3 kDiffuse;
uniform vec3 kSpecular;

uniform int numLights;
uniform int lightTypes[MAX_LIGHTS];
uniform vec3 lightPositions[MAX_LIGHTS];
uniform vec3 ambientIntensities[MAX_LIGHTS];
uniform vec3 diffuseIntensities[MAX_LIGHTS];
uniform vec3 specularIntensities[MAX_LIGHTS];

in vec3 position;
in vec3 normal;
in vec4 color;
in vec2 texCoord;

out vec4 vertColor;
out vec2 uv;

void main()
{
    vec3 worldPosition = (modelMatrix * vec4(position, 1)).xyz;
    vec3 worldNormal = normalize(normalMatrix * vec4(normal, 0)).xyz;

    vec3 illumination = vec3(0, 0, 0);
    for (int i=0; i < numLights; i++)
    {
        illumination += kAmbient * ambientIntensities[i];

        if(lightTypes[i] == DIRECTIONAL_LIGHT)
        {
            vec3 l = normalize(lightPositions[i]);
            float diffuseComponent = max(dot(worldNormal, l), 0.0);
            illumination += diffuseComponent * kDiffuse * diffuseIntensities[i];
        }
    }

    vertColor = color;
    vertColor.rgb *= illumination;

    uv = texCoord;
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1);
}