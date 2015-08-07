
/*!
  \file     VDBIO.cpp
  \author       Tody
  VDBIO definition.
  date      2015/08/07
*/

#include "VDBIO.h"
#include <openvdb/openvdb.h>
#include <openvdb/tools/Dense.h>

bool VDBIO::writeVolume ( const std::string& filePath, std::vector<short>& volume, int width, int height, int depth )
{
    openvdb::Coord bmin ( 0, 0, 0 );
    openvdb::Coord bmax ( width, height, depth );
    const openvdb::CoordBBox bbox ( openvdb::Coord ( 0, 0, 0 ),
                                    openvdb::Coord ( width, height, depth ) );
    openvdb::tools::Dense<float> dense ( bbox );

    openvdb::Coord xyz;
    int& x = xyz[0], &y = xyz[1], &z = xyz[2];

    float density_max = 0.0f;
    float density_min = 2222222.0f;

    for ( x = bmin.x(); x < bmax.x(); ++x )
    {
        for ( y = bmin.y(); y < bmax.y(); ++y )
        {
            for ( z = bmin.z(); z < bmax.z(); ++z )
            {
                density_max = std::max<float> ( density_max, volume[z * width * height + y * width + x] );
                density_min = std::min<float> ( density_min, volume[z * width * height + y * width + x] );
            }
        }
    }

    std::cout << "density_max: " << density_max << std::endl;
    std::cout << "density_min: " << density_min << std::endl;

    for ( x = bmin.x(); x < bmax.x(); ++x )
    {
        for ( y = bmin.y(); y < bmax.y(); ++y )
        {
            for ( z = bmin.z(); z < bmax.z(); ++z )
            {
                float d = ( volume[z * width * height + y * width + x] ) / ( density_max );
                d = std::max ( d, 0.0f );
                dense.setValue ( xyz, d );
            }
        }
    }


    const float tolerance = 0.05f;

    openvdb::FloatGrid::Ptr grid = openvdb::FloatGrid::create ( 0.0f );

    openvdb::tools::copyFromDense ( dense, *grid, tolerance );

    grid->setName ( "density" );
    grid->setGridClass ( openvdb::GRID_FOG_VOLUME );

    openvdb::io::File file ( filePath );

    openvdb::GridPtrVec grids;
    grids.push_back ( grid );
    // Write out the contents of the container.
    file.write ( grids );
    file.close();

    return true;
}
