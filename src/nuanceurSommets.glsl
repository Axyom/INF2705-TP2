#version 410

const float M_PI = 3.14159265358979323846;	// pi
const float M_PI_2 = 1.57079632679489661923;	// pi/2

layout(location=0) in vec4 Vertex;
layout(location=3) in vec4 Color;

out Attribs {
   vec4 couleur;
   // float clipDistanceDragage;
   // float clipDistanceRayonsX;
} AttribsOut;

void main( void )
{
    gl_Position = Vertex;
    // couleur du sommet
    AttribsOut.couleur = Color;
}
