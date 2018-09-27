#version 410

const float M_PI = 3.14159265358979323846;	// pi
const float M_PI_2 = 1.57079632679489661923;	// pi/2

layout(triangles) in;
layout(triangle_strip, max_vertices = 6) out;

uniform vec4 planDragage; // équation du plan de dragage
uniform vec4 planRayonsX; // équation du plan de rayonX

uniform mat4 matrModel;
uniform mat4 matrVisu;
uniform mat4 matrProj;

out Attribs {
   vec4 couleur;
   // float clipDistanceDragage;
   // float clipDistanceRayonsX;
} AttribsOut;

in Attribs {
   vec4 couleur;
   // float clipDistanceDragage;
   // float clipDistanceRayonsX;
} AttribsIn[];

void main( void )
{
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 0; // première clôture

        vec4 pos = matrModel * gl_in[i].gl_Position; // position dans le repere du monde
        gl_Position = matrProj * matrVisu * pos; // transformation standard du sommet
        AttribsOut.couleur = AttribsIn[i].couleur;
        gl_ClipDistance[0] = dot( planRayonsX, pos );
        gl_ClipDistance[1] = dot( planDragage, pos );
        EmitVertex();
    }
    EndPrimitive();
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 1; // seconde clôture

        vec4 pos = matrModel * gl_in[i].gl_Position; // position dans le repere du monde
        gl_Position = matrProj * matrVisu * pos; // transformation standard du sommet
        AttribsOut.couleur = AttribsIn[i].couleur;
        gl_ClipDistance[0] = dot( planRayonsX, pos );
        gl_ClipDistance[1] = - dot( planDragage, pos );
        EmitVertex();
    }
    EndPrimitive();
}
