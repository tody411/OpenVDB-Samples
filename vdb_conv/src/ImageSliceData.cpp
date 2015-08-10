
/*!
  \file     ImageSliceData.cpp
  \author       Tody
  ImageSliceData definition.
  date      2015/08/10
*/

#include "ImageSliceData.h"

#include <iostream>

#include <opencv2/opencv.hpp>

#include <QDir>

void ImageSliceData::load()
{
    QDir sliceDataDir ( QString::fromStdString ( _dirPath ) );

    QStringList filters;
    filters << "*.bmp" << "*.dib" << "*.jpeg" << "*.jpg" << "*.jpe" << "*.jp2" <<
            "*.png" << "*.pbm" << "*.pgm" << "*.ppm" << "*.sr" << "*.ras" <<
            "*.tiff" << "*.tif";

    sliceDataDir.setFilter ( QDir::Files );
    sliceDataDir.setNameFilters ( filters );
    QStringList imageNames = sliceDataDir.entryList();

    for ( int z = 0; z < imageNames.length(); z++ )
    {
        QString imageFile = sliceDataDir.absoluteFilePath ( imageNames[z] );
        load ( z, imageFile.toStdString() );
    }
}

void ImageSliceData::load ( int z, const std::string& filePath )
{
    cv::Mat image = cv::imread ( filePath );

    if ( image.cols != _data.width ) return;
    if ( image.rows != _data.height ) return;


    std::vector<cv::Mat> rgbChannels;
    cv::split ( image, rgbChannels );


    int height = rgbChannels[0].rows;
    int width = rgbChannels[0].cols;

    for ( int y = 0; y < height; y++ )
    {
        for ( int x = 0; x < width; x++ )
        {
            uchar d = rgbChannels[0].at<uchar> ( y, x );

            _data.setValue ( x, y, z, d );
        }
    }

}