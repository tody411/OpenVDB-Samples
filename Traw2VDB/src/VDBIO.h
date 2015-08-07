
/*!
  \file     VDBIO.h
  \author   Tody
  VDBIO definition.
  \date     2015/08/07
*/

#ifndef VDBIO_H
#define VDBIO_H

#include <string>
#include <vector>

//! VDBIO implementation.
namespace VDBIO
{
    bool writeVolume ( const std::string& filePath, std::vector<short>& volume, int width, int height, int depth );
};

#endif

