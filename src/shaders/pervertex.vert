#version 300 es

precision mediump float;

/* Lecture 21
 * CSCI 4611, Fall 2022, University of Minnesota
 * Instructor: Evan Suma Rosenberg <suma@umn.edu>
 * License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
 */ 

// The shader will be identical to the unlit shader in GopherGfx.

const int MAX_LIGHTS = 8;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

uniform vec3 kAmbient;
uniform vec3 kDiffuse;
uniform vec3 kSpecular;

uniform int numLights;
uniform vec3 ambientIntensities[MAX_LIGHTS];
uniform vec3 diffuseIntensities[MAX_LIGHTS];
uniform vec3 specularIntensities[MAX_LIGHTS];

in vec3 position;
in vec4 color;
in vec2 texCoord;

out vec4 vertColor;
out vec2 uv;

void main()
{
    vec3 illumination = vec3(0, 0, 0);
    for (int i=0; i < numLights; i++)
    {
        illumination += kAmbient * ambientIntensities[i];
    }

    vertColor = color;
    vertColor.rgb *= illumination;

    uv = texCoord;
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1);
}