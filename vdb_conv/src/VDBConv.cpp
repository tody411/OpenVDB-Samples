
/*!
  \file     VDBConv.cpp
  \author       Tody
  VDBConv definition.
  date      2015/08/07
*/

#include "VDBConv.h"

#include <openvdb/tools/Dense.h>

template<typename ValueType>
openvdb::FloatGrid::Ptr vdb_conv::grid2vdb ( GridData<ValueType>& gridData, float tolerance )
{
    openvdb::Coord bmin ( 0, 0, 0 );
    openvdb::Coord bmax ( gridData.width, gridData.height, gridData.depth );
    const openvdb::CoordBBox bbox ( bmin,
                                    bmax );
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
                float density = gridData.getValue ( x, y, z );
                density_max = std::max<float> ( density_max, density );
                density_min = std::min<float> ( density_min, density );
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
                float density = ( float ) gridData.getValue ( x, y, z ) / ( density_max );
                density = std::max ( density, 0.0f );
                dense.setValue ( xyz, density );
            }
        }
    }

    openvdb::FloatGrid::Ptr vdbGrid = openvdb::FloatGrid::create ( 0.0f );

    openvdb::tools::copyFromDense ( dense, *vdbGrid, tolerance );

    vdbGrid->setName ( "density" );
    vdbGrid->setGridClass ( openvdb::GRID_FOG_VOLUME );

    return vdbGrid;
}

template openvdb::FloatGrid::Ptr vdb_conv::grid2vdb <short> ( GridData<short>& gridData, float tolerance );
template openvdb::FloatGrid::Ptr vdb_conv::grid2vdb <unsigned char> ( GridData<unsigned char>& gridData, float tolerance );
template openvdb::FloatGrid::Ptr vdb_conv::grid2vdb <float> ( GridData<float>& gridData, float tolerance );
template openvdb::FloatGrid::Ptr vdb_conv::grid2vdb <double> ( GridData<double>& gridData, float tolerance );