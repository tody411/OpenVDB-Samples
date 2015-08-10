
/*!
  \file     VDBIO.h
  \author   Tody
  VDBIO definition.
  \date     2015/08/07
*/

#ifndef VDBIO_H
#define VDBIO_H

#include <string>
#include "GridData.h"
#include <openvdb/openvdb.h>

//! VDBIO implementation.
namespace vdb_io
{
    bool loadTraw ( const std::string& filePath, ShortGridData& data );

    bool loadImageSlices ( const std::string& dirPath, UcharGridData& data );

    bool writeGrid ( const std::string& filePath, openvdb::FloatGrid::Ptr vdbGrid );
};

#endif

