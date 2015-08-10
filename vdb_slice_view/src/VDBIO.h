
/*!
  \file     VDBIO.h
  \author   Tody
  VDBIO definition.
  \date     2015/08/07
*/

#ifndef VDBIO_H
#define VDBIO_H

#include <string>
#include "TrawData.h"
#include <openvdb/openvdb.h>

//! VDBIO implementation.
namespace vdb_io
{
    bool loadTraw ( const std::string& filePath, TrawData& data );

    bool writeGrid ( const std::string& filePath, openvdb::FloatGrid::Ptr vdbGrid );
};

#endif

