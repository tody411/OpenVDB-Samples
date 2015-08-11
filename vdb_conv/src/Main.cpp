//! Main function of VDB file converter.
/*!
  \file     VDBConv.cpp
  \author       Tody
  date      2015/08/07

  Usage: vdb_conv.exe [options] input output
  Simple file converter for OpenVDB files.

  Options:
    -?, -h, --help          Displays this help.
    -v, --version           Displays version information.
    -t, --tolerance         Error tolerance for conversion.

  Arguments:
    input                  Input file path to convert.
    output                 Output file path.
*/

#include <openvdb/openvdb.h>

#include <QCoreApplication>
#include <QCommandLineParser>
#include <QDir>
#include <QDebug>

#include "TimerLog.h"
#include "GridData.h"
#include "VDBIO.h"
#include "VDBConv.h"



openvdb::FloatGrid::Ptr traw2vdb ( const std::string& inputFilePath, float tolerance )
{
    std::cout << "input: " << inputFilePath << std::endl;
    std::cout << "tolerance: " << tolerance <<  std::endl;

    TimerLog tl;
    ShortGridData trawData;
    if ( vdb_io::loadTraw ( inputFilePath, trawData ) )
    {
        std::cout << "  - Success: load" << std::endl;
    }
    std::cout << trawData << std::endl;
    tl ( "Load Traw files" );

    openvdb::FloatGrid::Ptr vdbGrid = vdb_conv::grid2vdb ( trawData, tolerance );
    tl ( "Convert Traw to VDB" );
    return vdbGrid;
}

openvdb::FloatGrid::Ptr slice2vdb ( const std::string& inputDirPath, float tolerance  )
{
    std::cout << "input: " << inputDirPath << std::endl;
    std::cout << "tolerance: " << tolerance << std::endl;

    TimerLog tl;
    UcharGridData sliceData;
    if ( vdb_io::loadImageSlices ( inputDirPath, sliceData ) )
    {
        std::cout << "  - Success: load" << std::endl;
    }
    tl ( "Load slice images" );

    std::cout << sliceData << std::endl;

    openvdb::FloatGrid::Ptr vdbGrid = vdb_conv::grid2vdb ( sliceData, tolerance );
    tl ( "Converting Image slice to VDB" );
    return vdbGrid;
}

int main ( int argc, char* argv[] )
{
    QCoreApplication app ( argc, argv );
    QCoreApplication::setApplicationName ( "vdb_conv" );
    QCoreApplication::setApplicationVersion ( "1.0" );

    QCommandLineParser parser;
    parser.setApplicationDescription ( "Simple file converter for OpenVDB files." );
    parser.addHelpOption();
    parser.addVersionOption();

    parser.addPositionalArgument ( "input", "Input file path to convert."  );
    parser.addPositionalArgument ( "output", "Output file path." );

    QCommandLineOption toleranceOption ( QStringList() << "t" << "tolerance", "Error tolerance for conversion." );
    toleranceOption.setDefaultValue ( "0.05" );
    parser.addOption ( toleranceOption );

    parser.process ( app );

    openvdb::initialize();

    const QStringList args = parser.positionalArguments();


    qDebug() << args;

    QFileInfo inputInfo ( args[0] );

    QString outputFile ( "test.vdb" );

    qSetRealNumberPrecision ( 10 );
    float tolerance = parser.value ( toleranceOption ).toDouble();

    openvdb::FloatGrid::Ptr vdbGrid = NULL;

    if ( inputInfo.isFile() )
    {
        std::cout << "==========================" << std::endl;
        std::cout << "Traw to VDB." << std::endl;
        std::cout << "==========================" << std::endl;

        vdbGrid = traw2vdb ( inputInfo.absoluteFilePath().toStdString(), tolerance );

        outputFile =  inputInfo.absolutePath().replace ( ".traw3D_ss", ".vdb" );
    }

    else
    {
        std::cout << "==========================" << std::endl;
        std::cout << "Image Slices to VDB." << std::endl;
        std::cout << "==========================" << std::endl;
        vdbGrid = slice2vdb ( inputInfo.absoluteFilePath().toStdString(), tolerance );
        outputFile =  inputInfo.absolutePath() + ".vdb" ;
    }

    if ( args.length() > 1 )
    {
        outputFile = args[1];
    }

    TimerLog tl;
    vdb_io::writeDensityGrid ( outputFile.toStdString(), vdbGrid );
    tl ( "Write VDB files" );

    return 0;
}
