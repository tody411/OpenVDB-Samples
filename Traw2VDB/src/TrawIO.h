
/*!
  \file     TrawIO.h
  \author   Tody
  TrawIO definition.
  \date     2015/08/07
*/

#ifndef TRAWIO_H
#define TRAWIO_H

#include <string>
#include <vector>

//! TrawIO implementation.
namespace TrawIO
{

    bool loadVolume ( const std::string& filePath, std::vector<short>& volume, int& width, int& height, int& depth );
};

#endif

