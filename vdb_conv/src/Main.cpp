#include <openvdb/openvdb.h>

#include "TimerLog.h"
#include "GridData.h"
#include "VDBIO.h"
#include "VDBConv.h"

#include <QDir>

openvdb::FloatGrid::Ptr traw2vdb ( const std::string& srcFilePath )
{
    TimerLog tl;
    ShortGridData trawData;
    if ( vdb_io::loadTraw ( srcFilePath, trawData ) )
    {
        std::cout << "SuccessFully loaded" << std::endl;
    }
    tl ( " vdb_io::loadTraw" );

    std::cout << trawData << std::endl;

    openvdb::FloatGrid::Ptr vdbGrid = vdb_conv::grid2vdb ( trawData );
    tl ( "vdb_conv::grid2vdb" );
    return vdbGrid;
}

openvdb::FloatGrid::Ptr slice2vdb ( const std::string& srcDirPath )
{
    TimerLog tl;
    UcharGridData sliceData;
    if ( vdb_io::loadImageSlices ( srcDirPath, sliceData ) )
    {
        std::cout << "SuccessFully loaded" << std::endl;
    }
    tl ( " vdb_io::loadImageSlices" );

    std::cout << sliceData << std::endl;

    openvdb::FloatGrid::Ptr vdbGrid = vdb_conv::grid2vdb ( sliceData );
    tl ( "vdb_conv::grid2vdb" );
    return vdbGrid;
}

int main ( int argc, char* argv[] )
{
    std::string trawFilePath ( argv[1] );

    std::string vdbFilePath ( "test.vdb" );

    if ( argc > 2 )
    {
        vdbFilePath = argv[2];
    }

    openvdb::initialize();

    QFileInfo srcInfo ( argv[1] );

    openvdb::FloatGrid::Ptr vdbGrid = NULL;

    if ( srcInfo.isFile() )
    {
        vdbGrid = traw2vdb ( argv[1] );
    }

    else
    {
        vdbGrid = slice2vdb ( argv[1] );
    }

    TimerLog tl;
    vdb_io::writeGrid ( vdbFilePath, vdbGrid );
    tl ( "vdb_io::writeGrid" );

    return 0;
}
