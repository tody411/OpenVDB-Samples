
/*!
  \file     VDBIO.cpp
  \author       Tody
  VDBIO definition.
  date      2015/08/07
*/

#include "VDBIO.h"

#include <openvdb/tools/Dense.h>

#include "ImageSliceIO.h"

bool vdb_io::loadTraw ( const std::string& filePath, ShortGridData& data )
{
    FILE* fp = fopen ( filePath.c_str(), "rb" );
    if ( fp == 0 ) return false;

    int width, height, depth;

    fread ( &width , sizeof ( int   ), 1, fp );
    fread ( &height , sizeof ( int   ), 1, fp );
    fread ( &depth , sizeof ( int   ), 1, fp );

    double px, py, pz; // pitch in x,y,z axes
    fread ( &px, sizeof ( double ), 1, fp );
    fread ( &py, sizeof ( double ), 1, fp );
    fread ( &pz, sizeof ( double ), 1, fp );

    //read signed short array
    data.create ( width, height, depth );

    if ( fread ( data.data(), sizeof ( short ), width * height * depth, fp ) != width * height * depth )
    {
        fclose ( fp );
        return false;
    }

    fclose ( fp );
    return true;
}

bool vdb_io::loadImageSlices ( const std::string& dirPath, UcharGridData& data )
{
    ImageSliceIO imageSliceIO ( dirPath );
    imageSliceIO.load ( data );
    return true;
}

bool vdb_io::writeDensityGrid ( const std::string& filePath, openvdb::FloatGrid::Ptr vdbGrid  )
{
    openvdb::io::File file ( filePath );

    openvdb::GridPtrVec grids;
    grids.push_back ( vdbGrid );
    // Write out the contents of the container.
    file.write ( grids );
    file.close();

    return true;
}
