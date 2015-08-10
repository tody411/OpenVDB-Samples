
/*!
  \file     ImageSliceIO.h
  \author   Tody
  ImageSliceIO definition.
  \date     2015/08/10
*/

#ifndef IMAGESLICEIO_H
#define IMAGESLICEIO_H

#include <string>

#include "GridData.h"

//! ImageSliceIO implementation.
class ImageSliceIO
{
public :
    //! Constructor.
    ImageSliceIO ( const std::string& dirPath )
        : _dirPath ( dirPath )
    {}

    //! Destructor.
    virtual ~ImageSliceIO() {}

    void load ( UcharGridData& data );

private:
    void initialLoad ( int depth, const std::string& filePath, UcharGridData& data );

    void loadDepth ( int z, const std::string& filePath, UcharGridData& data );

private:
    std::string _dirPath;
};

#endif

