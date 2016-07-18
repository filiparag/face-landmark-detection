#! /usr/bin/python

import os
import render
from prepare_data import plot, workDirectory
import cv2


def getFileList(databaseDirectory):

    files = []

    for directoryName, subDirectoryList, fileList in os.walk(databaseDirectory):
        fileList = sorted(fileList)
        for fileName in fileList:
            if fileName.endswith('01.png'):
                files.append(os.path.join(directoryName, fileName)[:-4])

    return files


def copyFiles(fileList, databaseDirectory):

    for index, file in enumerate(fileList):
        os.system('cp %s.png %s%s.png' % (file, databaseDirectory, index))
        os.system('cp %s_landmarks.txt %s%s.landmarks' % (file, databaseDirectory, index))


def fixLandmarkPoints(numberOfFIles):

    #                 [1   2   3   4   5   6   7   8   9 *10  11 *12  13 *14  15 *16  17  18  19  20]
    targetLandmarks = [9, 18, 22, 23, 27, 31, 32, 36, 37, 38, 40, 42, 43, 44, 46, 48, 49, 52, 55, 58]

    for index in range(0, numberOfFIles):

        faceLandmarks = []

        with open('database/%s.landmarks' % index, 'r') as file:

            for lineIndex in range(1, 69):
                fileLine = file.readline()[:-1]
                fileLine = fileLine.split('   ')
                fileLine = [fileLine[1], fileLine[2]]
                fileLine[0] = int(float(fileLine[0][:-4]) * 10 ** int(fileLine[0][len(fileLine[0]) - 3:]))
                fileLine[1] = int(float(fileLine[1][:-4]) * 10 ** int(fileLine[1][len(fileLine[1]) - 3:]))
                if lineIndex in targetLandmarks:
                    faceLandmarks.append(fileLine)

        faceLandmarks[9][0] = (faceLandmarks[8][0] + faceLandmarks[10][0]) / 2
        faceLandmarks[11][0] = (faceLandmarks[8][0] + faceLandmarks[10][0]) / 2
        faceLandmarks[13][0] = (faceLandmarks[12][0] + faceLandmarks[14][0]) / 2
        faceLandmarks[15][0] = (faceLandmarks[12][0] + faceLandmarks[14][0]) / 2

        with open('database/%s.landmarks' % index, 'w') as file:

            for landmark in faceLandmarks:
                file.write('%s\n' % landmark[0])
                file.write('%s\n' % landmark[1])

        keypoints = []
        keypoints.append([(faceLandmarks[11][0] + faceLandmarks[9][0]) / 2,
                          (faceLandmarks[11][1] + faceLandmarks[9][1]) / 2])
        keypoints.append([(faceLandmarks[15][0] + faceLandmarks[13][0]) / 2,
                          (faceLandmarks[15][1] + faceLandmarks[13][1]) / 2])
        keypoints.append([(faceLandmarks[18][0] + faceLandmarks[16][0]) / 2,
                          (faceLandmarks[18][1] + faceLandmarks[16][1]) / 2])

        with open('database/%s.keypoints' % index, 'w') as file:

            for keypoint in keypoints:
                file.write('%s\n%s\n' % (keypoint[0], keypoint[1]))

        if plot:
            render.landmarks('database/%s.png' % index, keypoints, 255)


def loadImages(numberOfFiles):

    images = []

    for index in range(0, numberOfFiles):
        images.append(cv2.imread('database/%s.png' % index, 0))

    return images


def writeDetectedKeypoints(index, keypoints):

    with open('database/%s.manual.keypoints' % index, 'w') as file:
        for keypoint in keypoints:
            file.write('%s\n' % keypoint[0])
            file.write('%s\n' % keypoint[1])
