
vdb_conv
====

Simple file converter for OpenVDB.


## Usage

``` bash
vdb_conv.exe [options] input output

Options:
  -?, -h, --help   Displays this help.
  -v, --version    Displays version information.
  -t, --tolerance  Error tolerance for conversion.

Arguments:
  input            Input file path to convert.
  output           Output file path.
```

## Examples

### Convert image slices to OpenVDB file.
``` bash
# slice_dir: Directory includes image slices (*.png, *.tiff)
vdb_conv.exe slice_dir slices.vdb
```

## License

The MIT License 2015 (c) tody