#! /usr/bin/python

import os
import file_management as fmng


plot = False
workDirectory = os.path.dirname(os.path.realpath(__file__))


def prepareData():

    fileList = fmng.getFileList('../database/')
    fmng.copyFiles(fileList, 'database/')
    fmng.fixLandmarkPoints(len(fileList))


if __name__ == '__main__':
    prepareData()