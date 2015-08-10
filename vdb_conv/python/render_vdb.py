
# -*- coding: utf-8 -*-
## @package render_vdb
#
#  render_vdb utility package.
#  @author      tody
#  @date        2015/08/07

import os

src_dir = "E:/datasets/OpenVDB/20150804"
dst_dir = "E:/datasets/OpenVDB/20150804/rendered"


def lsVBDFiles(dir):
    files = []
    for file_name in os.listdir(dir):
        if ".vdb" in file_name:
            files.append(os.path.join(dir, file_name))
    return files


def binFile():
    return os.path.join("vdb_render.exe")


def renderDir(src_dir, dst_dir):
    if not os.path.exists(dst_dir):
        os.makedirs(dst_dir)

    vdb_files = lsVBDFiles(src_dir)

    for vdb_file in vdb_files:
        dst_file = os.path.basename(vdb_file)
        dst_file = os.path.join(dst_dir, dst_file.replace(".vdb", ".ppm"))

        print dst_file

        if os.path.exists(dst_file):
            continue

        cmd = binFile() + " " + vdb_file + " " + dst_file
        cmd += " -res 512x512 -translate 0,0,1000 -absorb 0.4,0.2,0.1 -gain 0.2 -v"
        print cmd
        os.system(cmd)


def convertImages(dst_dir):
    cmd = "mogrify -format png %s/*.ppm" % dst_dir
    os.system(cmd)

if __name__ == '__main__':
    renderDir(src_dir, dst_dir)
    convertImages(dst_dir)

