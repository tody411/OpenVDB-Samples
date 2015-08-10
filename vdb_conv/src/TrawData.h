/*!
    \file       TrawData.h
    \author     Tody
    TrawData definition.
    \date       2015/08/07
*/

#ifndef TRAWDATA_H
#define TRAWDATA_H

#include <vector>

//! TrawData implementation.
class TrawData
{
public :
    //! Constructor.
    TrawData();

    //! Destructor.
    virtual ~TrawData();

    short getValue ( int x, int y, int z )
    {
        return volume[z * width * height + y * width + x];
    }

public:
    //! Traw volume data.
    std::vector<short> volume;

    int width;
    int height;
    int depth;
};

#endif