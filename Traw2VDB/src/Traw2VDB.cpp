#include <openvdb/openvdb.h>

#include "TimerLog.h"
#include "TrawIO.h"
#include "VDBIO.h"
#include "VDBInfo.h"

int main ( int argc, char* argv[] )
{
    std::string trawFilePath ( argv[1] );

    std::string vdbFilePath ( "test.vdb" );

    if ( argc > 2 )
    {
        vdbFilePath = argv[2];
    }

    openvdb::initialize();

    VDBInfo::showVDBInfo ( "C:/Users/tody/Documents/GitHub/OpenVDB-Samples/Traw2VDB/bunny_cloud.vdb" );
    //return 0;

    std::vector<short> volume;
    int width, height, depth;

    TimerLog tl;
    if ( TrawIO::loadVolume ( trawFilePath, volume, width, height, depth ) )
    {
        std::cout << "SuccessFully loaded" << std::endl;
    }
    tl ( "TrawIO::loadVolume" );

    std::cout << "(width, height, depth): (" << width << ", " << height << ", " << depth << ")" << std::endl;

    VDBIO::writeVolume ( vdbFilePath, volume, width, height, depth );
    tl ( "VDBIO::writeVolume" );

    return 0;
}
