
/*!
  \file     VDBInfo.cpp
  \author       Tody
  VDBInfo definition.
  date      2015/08/07
*/

#include "VDBInfo.h"
#include <openvdb/openvdb.h>

void VDBInfo::showVDBInfo ( const std::string& filePath )
{
    openvdb::io::File file ( filePath );
// Open the file.  This reads the file header, but not any grids.
    file.open();
// Loop over all grids in the file and retrieve a shared pointer
// to the one named "LevelSetSphere".  (This can also be done
// more simply by calling file.readGrid("LevelSetSphere").)
    openvdb::GridBase::Ptr baseGrid;
    for ( openvdb::io::File::NameIterator nameIter = file.beginName();
            nameIter != file.endName(); ++nameIter )
    {
        std::cout << "GridName: " << nameIter.gridName() << std::endl;
    }

    openvdb::GridBase::Ptr densityGrid;
    densityGrid = file.readGrid ( "density" );

    file.close();

    std::cout << "Creator: " << densityGrid->getCreator() << std::endl;
    std::cout << "GridClass: " << densityGrid->getGridClass() << std::endl;
    std::cout << "VectorType: " << densityGrid->getVectorType() << std::endl;
}
