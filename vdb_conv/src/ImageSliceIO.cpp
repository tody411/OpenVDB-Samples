
/*!
  \file     ImageSliceIO.cpp
  \author       Tody
  ImageSliceIO definition.
  date      2015/08/10
*/

#include "ImageSliceIO.h"

#include <opencv2/opencv.hpp>

#include <QDir>
#include <QDebug>

void ImageSliceIO::load ( UcharGridData& data )
{
    QDir sliceDataDir ( QString::fromStdString ( _dirPath ) );

    QStringList filters;
    filters << "*.bmp" << "*.dib" << "*.jpeg" << "*.jpg" << "*.jpe" << "*.jp2" <<
            "*.png" << "*.pbm" << "*.pgm" << "*.ppm" << "*.sr" << "*.ras" <<
            "*.tiff" << "*.tif";

    sliceDataDir.setFilter ( QDir::Files );
    sliceDataDir.setNameFilters ( filters );
    QStringList imageNames = sliceDataDir.entryList();

    qDebug() << imageNames;

    QStringList imageFiles;
    int depth =  imageNames.length();
    for ( int z = 0; z < depth; z++ )
    {
        QString imageFile = sliceDataDir.absoluteFilePath ( imageNames[z] );
        imageFiles << imageFile;
    }


    initialLoad ( depth, imageFiles[0].toStdString(), data );

    for ( int z = 0; z < depth; z++ )
    {
        QString imageFile = imageFiles[z];
        loadDepth ( z, imageFile.toStdString(), data );
    }
}

void ImageSliceIO::initialLoad ( int depth, const std::string& filePath, UcharGridData& data )
{
    cv::Mat image = cv::imread ( filePath );
    data.create ( image.cols, image.rows, depth );
}

void ImageSliceIO::loadDepth ( int z, const std::string& filePath, UcharGridData& data )
{
    cv::Mat image = cv::imread ( filePath );

    if ( image.cols != data.width ) return;
    if ( image.rows != data.height ) return;


    std::vector<cv::Mat> rgbChannels;
    cv::split ( image, rgbChannels );

    int height = rgbChannels[0].rows;
    int width = rgbChannels[0].cols;

    for ( int y = 0; y < height; y++ )
    {
        for ( int x = 0; x < width; x++ )
        {
            uchar d = rgbChannels[0].at<uchar> ( y, x );

            data.setValue ( x, y, z, d );
        }
    }
}