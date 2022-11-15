#version 300 es

precision mediump float;

/* Lecture 21
 * CSCI 4611, Fall 2022, University of Minnesota
 * Instructor: Evan Suma Rosenberg <suma@umn.edu>
 * License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
 */ 

// The shader will be identical to the unlit shader in GopherGfx.

uniform int useTexture;
uniform sampler2D textureImage;

in vec4 vertColor;
in vec2 uv;

out vec4 fragColor;

void main()
{
    fragColor = vertColor;

    if(useTexture != 0)
    {
        fragColor *= texture(textureImage, uv);
    }
}