
OpenVDB samples (C++)
====

Simple OpenVDB samples.

* [**vdb_conv**](vdb_conv)
    - Simple file converter for OpenVDB.
* [**vdb_slice_view**](vdb_slice_view)
    - Simple slice viewer for OpenVDB.


## Result
*Status*: Under construction.

## Installation

*Note*: This program was only tested on **Windows** with **Visual Studio 2012**.
**Linux** and **Mac OS** are not officially supported,
but the following instructions might be helpful for installing on those environments.

### Dependencies
Please install the following required libraries.

* For OpenVDB
    - **OpenVDB**
    - **OpenEXR**
    - **boost**
    - **ZLib**
    - **IlmBase**
    - **TBB**
* For Image
    - **OpenCV** (version 2.4.9 or higher)
* For UI
    - **Qt** (version 5.2.1 or higher)

To build the OpenVDB libraries, please follow the instruction of [Windows Build of OpenVDB](https://github.com/rchoetzlein/win_openvdb).
You can use CMake mechanism to build sample projects with the following directory structure for the external libraries.

* ```EXT_LIB_ROOT```
    - ```boost```
        - ```include```
        - ```lib```
    - ```IlmBase```
        - ```include```
        - ```lib```
    - ```OpenEXR```
        - ```include```
        - ```lib```
    - ```OpenVDB```
        - ```include```
        - ```lib```
    - ```tbb43```
        - ```include```
        - ```lib```
    - ```zlib```
        - ```include```
        - ```lib```

## Projects
More details are provided by README in each project directory.

* [**vdb_conv**](vdb_cons)
* [**vdb_slice_view**](vdb_slice_view)

## Future tasks

* [ ] Implement more samples.

## License

The MIT License 2015 (c) tody