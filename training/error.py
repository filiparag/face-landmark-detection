#! /usr/bin/python

import math

def keypointDetectionErrorRate(image, index, keypoints):

    error = []

    with open('database/%s.keypoints' % index, 'r') as file:

        for it in range(0, 3):
            currentError = abs(math.sqrt(abs(int(file.readline()) - keypoints[it][0]) ** 2 +
                                         abs(int(file.readline()) - keypoints[it][1]) ** 2))
            error.append(round(currentError, 2))

    return error
