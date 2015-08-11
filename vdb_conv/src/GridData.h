
/*!
  \file     GridData.h
  \author   Tody
  GridData definition.
  \date     2015/08/10
*/

#ifndef GRIDDATA_H
#define GRIDDATA_H

#include <iostream>
#include <vector>

//! GridData implementation.
template<typename ValueType>
class GridData
{
public :
    //! Constructor.
    GridData () {}

    //! Constructor with the target grid size.
    GridData ( int width, int height, int depth )
        : width ( width ), height ( height ), depth ( depth )
    {
        _data.resize ( width * height * depth );
    }

    //! Destructor.
    virtual ~GridData()
    {
        _data.clear();
    }

    //! Create grid data with the target grid size.
    void create ( int width, int height, int depth )
    {
        this->width = width;
        this->height = height;
        this->depth = depth;

        _data.resize ( width * height * depth );
    }

    //! Get value for the target x, y, z.
    short getValue ( int x, int y, int z )
    {
        return _data[z * width * height + y * width + x];
    }

    //! Set value for the target x, y, z.
    void setValue ( int x, int y, int z, short d )
    {
        _data[z * width * height + y * width + x] = d;
    }

    //! Data pointer.
    ValueType* data()
    {
        return &_data[0];
    }

    void printSizeInfo ( std::ostream& stream ) const
    {
        stream << "  - (width, height, depth): (" << width << ", " << height << ", " << depth << ")" << std::endl;
    }

public:
    //! Grid data.
    std::vector<ValueType> _data;

    //! Width.
    int width;

    //! Height.
    int height;

    //! Depth.
    int depth;

};


typedef GridData<short> ShortGridData;
typedef GridData<unsigned char> UcharGridData;
typedef GridData<float> FloatGridData;

template<typename ValueType>
std::ostream& operator<< ( std::ostream& stream, const GridData<ValueType>& data )
{
    data.printSizeInfo ( stream );
    return stream;
}


#endif

