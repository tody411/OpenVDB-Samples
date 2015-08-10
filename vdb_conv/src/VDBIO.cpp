
/*!
  \file     VDBIO.cpp
  \author       Tody
  VDBIO definition.
  date      2015/08/07
*/

#include "VDBIO.h"

#include <openvdb/tools/Dense.h>

bool vdb_io::loadTraw ( const std::string& filePath, TrawData& data )
{
    FILE* fp = fopen ( filePath.c_str(), "rb" );
    if ( fp == 0 ) return false;

    fread ( &data.width , sizeof ( int   ), 1, fp );
    fread ( &data.height , sizeof ( int   ), 1, fp );
    fread ( &data.depth , sizeof ( int   ), 1, fp );

    double px, py, pz; // pitch in x,y,z axes
    fread ( &px, sizeof ( double ), 1, fp );
    fread ( &py, sizeof ( double ), 1, fp );
    fread ( &pz, sizeof ( double ), 1, fp );

    //read signed short array
    data.volume.resize ( data.width * data.height * data.depth );

    if ( fread ( &data.volume[0], sizeof ( short ), data.width * data.height * data.depth, fp ) != data.width * data.height * data.depth )
    {
        fclose ( fp );
        return false;
    }

    fclose ( fp );
    return true;
}

bool vdb_io::writeGrid ( const std::string& filePath, openvdb::FloatGrid::Ptr vdbGrid  )
{
    openvdb::io::File file ( filePath );

    openvdb::GridPtrVec grids;
    grids.push_back ( vdbGrid );
    // Write out the contents of the container.
    file.write ( grids );
    file.close();

    return true;
}
