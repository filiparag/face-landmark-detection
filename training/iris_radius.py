#! /usr/bin/python

import math
import os


def irisRadius():

    irisPoints = []

    files = []

    for directoryName, subDirectoryList, fileList in os.walk('../database/'):
        fileList = sorted(fileList)
        for fileName in fileList:
            if fileName.endswith('01.png'):
                files.append(os.path.join(directoryName, fileName)[:-4])

    #                 [ 0   1   2   3   4   5   6   7]
    targetLandmarks = [38, 39, 41, 42, 44, 45, 47, 48]

    for fileName in files:

        with open('%s_landmarks.txt' % fileName) as file:

            for lineIndex in range(1, 69):
                fileLine = file.readline()[:-1]
                fileLine = fileLine.split('   ')
                fileLine = [fileLine[1], fileLine[2]]
                fileLine[0] = int(float(fileLine[0][:-4]) * 10 ** int(fileLine[0][len(fileLine[0]) - 3:]))
                fileLine[1] = int(float(fileLine[1][:-4]) * 10 ** int(fileLine[1][len(fileLine[1]) - 3:]))
                if lineIndex in targetLandmarks:
                    irisPoints.append(fileLine)

    averageDistance = (
        math.sqrt((irisPoints[0][0] - irisPoints[2][0]) ** 2 + (irisPoints[0][1] - irisPoints[2][1]) ** 2) +
        math.sqrt((irisPoints[1][0] - irisPoints[3][0]) ** 2 + (irisPoints[1][1] - irisPoints[3][1]) ** 2) +
        math.sqrt((irisPoints[4][0] - irisPoints[6][0]) ** 2 + (irisPoints[4][1] - irisPoints[6][1]) ** 2) +
        math.sqrt((irisPoints[5][0] - irisPoints[7][0]) ** 2 + (irisPoints[5][1] - irisPoints[7][1]) ** 2)
    ) / 8

    print 'Average iris radius: %s px' % round(averageDistance, 2)


if __name__ == '__main__':
    irisRadius()