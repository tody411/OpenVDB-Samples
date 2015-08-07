
/*!
  \file     TrawIO.cpp
  \author       Tody
  TrawIO definition.
  date      2015/08/07
*/

#include "TrawIO.h"


bool TrawIO::loadVolume ( const std::string& filePath, std::vector<short>& volume, int& width, int& height, int& depth )
{
    FILE* fp = fopen ( filePath.c_str(), "rb" );
    if ( fp == 0 ) return false;

    fread ( &width , sizeof ( int   ), 1, fp );
    fread ( &height , sizeof ( int   ), 1, fp );
    fread ( &depth , sizeof ( int   ), 1, fp );

    double px, py, pz; // pitch in x,y,z axes
    fread ( &px, sizeof ( double ), 1, fp );
    fread ( &py, sizeof ( double ), 1, fp );
    fread ( &pz, sizeof ( double ), 1, fp );

    //read signed short array
    volume.resize ( width * height * depth );

    if ( fread ( &volume[0], sizeof ( short ), width * height * depth, fp ) != width * height * depth )
    {
        fclose ( fp );
        return false;
    }

    fclose ( fp );
    return true;
}