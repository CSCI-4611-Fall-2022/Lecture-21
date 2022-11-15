#version 300 es

precision mediump float;

/* Lecture 21
 * CSCI 4611, Fall 2022, University of Minnesota
 * Instructor: Evan Suma Rosenberg <suma@umn.edu>
 * License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
 */ 

// The shader will be identical to the unlit shader in GopherGfx.

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

in vec3 position;
in vec4 color;
in vec2 texCoord;

out vec4 vertColor;
out vec2 uv;

void main()
{
    vertColor = color;
    uv = texCoord;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1);
}