
/*!
  \file     ImageSliceData.h
  \author   Tody
  ImageSliceData definition.
  \date     2015/08/10
*/

#ifndef IMAGESLICEDATA_H
#define IMAGESLICEDATA_H

#include <string>
#include <vector>

#include <TrawData.h>

//! ImageSliceData implementation.
class ImageSliceData
{
public :
    //! Constructor.
    ImageSliceData ( const std::string& dirPath )
        : _dirPath ( dirPath )
    {}

    //! Destructor.
    virtual ~ImageSliceData() {}

    void load();

    void load ( int z, const std::string& filePath );

    TrawData* trawData();

private:
    std::string _dirPath;
    TrawData _data;
};

#endif

