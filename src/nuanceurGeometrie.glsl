#version 410

layout(triangles) in;
layout(triangle_strip, max_vertices = 6) out;

out Attribs {
   vec4 couleur;
} AttribsOut;

in Attribs {
   vec4 couleur;
   float clipDistanceDragage;
   float clipDistanceRayonsX;
} AttribsIn[];

void main( void )
{
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 0; // première clôture

        gl_ClipDistance[0] = AttribsIn[i].clipDistanceRayonsX;
        gl_ClipDistance[1] = AttribsIn[i].clipDistanceDragage;
        AttribsOut.couleur = AttribsIn[i].couleur;

        gl_Position = gl_in[i].gl_Position;

        EmitVertex();
    }
    EndPrimitive();
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 1; // seconde clôture

        gl_ClipDistance[0] = AttribsIn[i].clipDistanceRayonsX;
        gl_ClipDistance[1] = -AttribsIn[i].clipDistanceDragage;
        AttribsOut.couleur = AttribsIn[i].couleur;

        gl_Position = gl_in[i].gl_Position;

        EmitVertex();
    }
    EndPrimitive();
}
