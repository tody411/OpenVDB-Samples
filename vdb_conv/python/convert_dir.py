
# -*- coding: utf-8 -*-
## @package
#
#   utility package.
#  @author      tody
#  @date        2015/08/07

import os

src_dir = "E:/datasets/CTData_uRay/20150804"
dst_dir = "E:/datasets/OpenVDB/20150804"
bin_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../bin"))


def lsTrawFiles(dir):
    files = []
    for file_name in os.listdir(dir):
        if "traw" in file_name:
            files.append(os.path.join(dir, file_name))
    return files


def binFile():
    return os.path.join(bin_dir, "vdb_conv.exe")


def convertDir(src_dir, dst_dir):
    if not os.path.exists(dst_dir):
        os.makedirs(dst_dir)

    traw_files = lsTrawFiles(src_dir)

    for traw_file in traw_files:
        dst_file = os.path.basename(traw_file)
        dst_file = os.path.join(dst_dir, dst_file.replace(".traw3D_ss", ".vdb"))

        print dst_file

        if os.path.exists(dst_file):
            continue

        cmd = binFile() + " " + traw_file + " " + dst_file
        print cmd
        os.system(cmd)

if __name__ == '__main__':
    convertDir(src_dir, dst_dir)