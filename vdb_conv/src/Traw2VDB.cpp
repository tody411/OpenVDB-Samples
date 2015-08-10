#include <openvdb/openvdb.h>

#include "TimerLog.h"
#include "TrawData.h"
#include "VDBIO.h"
#include "VDBConv.h"

int main ( int argc, char* argv[] )
{
    std::string trawFilePath ( argv[1] );

    std::string vdbFilePath ( "test.vdb" );

    if ( argc > 2 )
    {
        vdbFilePath = argv[2];
    }

    openvdb::initialize();

    TimerLog tl;
    TrawData trawData;
    if ( vdb_io::loadTraw ( trawFilePath, trawData ) )
    {
        std::cout << "SuccessFully loaded" << std::endl;
    }
    tl ( " vdb_io::loadTraw" );

    std::cout << "(width, height, depth): (" << trawData.width << ", " << trawData.height << ", " << trawData.depth << ")" << std::endl;

    openvdb::FloatGrid::Ptr vdbGrid = vdb_conv::traw2vdb ( trawData );
    tl ( "vdb_conv::traw2vdb" );

    vdb_io::writeGrid ( vdbFilePath, vdbGrid );
    tl ( "vdb_io::writeGrid" );

    return 0;
}
