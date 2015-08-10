
/*!
  \file     VDBConv.h
  \author   Tody
  VDBConv definition.
  \date     2015/08/07
*/

#ifndef VDBCONV_H
#define VDBCONV_H

#include "TrawData.h"
#include <openvdb/openvdb.h>

//! VDBConv implementation.
namespace vdb_conv
{
    openvdb::FloatGrid::Ptr traw2vdb ( TrawData& trawVolume );



};

#endif

