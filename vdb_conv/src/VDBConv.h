
/*!
  \file     VDBConv.h
  \author   Tody
  VDBConv definition.
  \date     2015/08/07
*/

#ifndef VDBCONV_H
#define VDBCONV_H

#include "GridData.h"
#include <openvdb/openvdb.h>

//! VDBConv implementation.
namespace vdb_conv
{

    template<typename ValueType>
    openvdb::FloatGrid::Ptr grid2vdb ( GridData<ValueType>& gridData, float tolerance = 0.05f );

};

#endif

