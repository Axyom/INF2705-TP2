#version 410

uniform int modeSelection;
uniform vec4 planDragage; // équation du plan de dragage
uniform vec4 planRayonsX; // équation du plan de rayonX

// matrices
uniform mat4 matrModel;
uniform mat4 matrVisu;
uniform mat4 matrProj;

const float M_PI = 3.14159265358979323846;	// pi
const float M_PI_2 = 1.57079632679489661923;	// pi/2

layout(location=0) in vec4 Vertex;
layout(location=3) in vec4 Color;

out Attribs {
   vec4 couleur;
   float clipDistanceDragage;
   float clipDistanceRayonsX;
} AttribsOut;

void main( void )
{
    gl_Position = matrProj * matrVisu * matrModel * Vertex; // transformation standard du sommet

    // fondu de couleurs
    vec4 cyan = vec4(0., 1., 1., 1.);
    float colorFact = Vertex.z;

    if (modeSelection == 1)
    {
        AttribsOut.couleur = Color;
    }
    else
    {
        AttribsOut.couleur = mix(Color, cyan, colorFact);
    }
    vec4 pos = matrModel * Vertex; // position dans le repere du monde
    AttribsOut.clipDistanceDragage = dot( planDragage, pos);
    AttribsOut.clipDistanceRayonsX = dot(planRayonsX, pos);

}
