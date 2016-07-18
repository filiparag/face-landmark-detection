#! /usr/bin/python

import render
import file_management as fmng
import cv2
import error
from prepare_data import plot, workDirectory


cv2dir = '/usr/share/opencv/'


def calculateHistograms(image):

    horizontalHistogram, verticalHistogram = [0] * len(image[0]), [0] * len(image)

    for row in image:
        for p, pixel in enumerate(row):
            horizontalHistogram[p] += pixel

    for column in image.transpose():
        for p, pixel in enumerate(column):
            verticalHistogram[p] += pixel

    return horizontalHistogram, verticalHistogram


def calculateDeltaHistograms(image):

    differenceTreshold = 3
    horizontalHistogram, verticalHistogram = [0] * len(image[0]), [0] * len(image)

    for point, row in enumerate(image):
        for i in range(1, len(row)):
            if abs(int(row[i]) - int(row[i - 1])) > differenceTreshold:
                verticalHistogram[point] += abs(int(row[i]) - int(row[i - 1]))

    for point, column in enumerate(image.transpose()):
        for i in range(1, len(column)):
            if abs(int(column[i]) - int(column[i - 1])):
                horizontalHistogram[point] += abs(int(column[i]) - int(column[i - 1]))

    return horizontalHistogram, verticalHistogram


def locateFace(image):

    cv2eyesCascade = cv2.CascadeClassifier(cv2dir + 'haarcascades/haarcascade_mcs_eyepair_small.xml')
    eyes = cv2eyesCascade.detectMultiScale(image)
    if len(eyes) is 1:
        ex, ey, ew, eh = eyes[0]
        image = image[ey * 0.85:(ey+eh)*1.8, ex:ex+ew]
        return image, int(ex), int(ey * 0.85)
    else:
        return -1, -1, -1


def locatePupils(image, cropLeft, cropTop):

    leftEyeRegion = image[:len(image) / 2, :len(image[0]) / 2]
    rightEyeRegion = image[:len(image) / 2, len(image[0]) / 2:]

    leftEyeHistogramHorizontal, leftEyeHistogramVertical = calculateDeltaHistograms(leftEyeRegion)
    rightEyeHistogramHorizontal, rightEyeHistogramVertical = calculateDeltaHistograms(rightEyeRegion)

    leftPupilY = leftEyeHistogramVertical.index(max(leftEyeHistogramVertical)) + cropTop
    leftPupilX = leftEyeHistogramHorizontal.index(max(leftEyeHistogramHorizontal)) + cropLeft

    rightPupilY = rightEyeHistogramVertical.index(max(rightEyeHistogramVertical)) + cropTop
    rightPupilX = rightEyeHistogramHorizontal.index(max(rightEyeHistogramHorizontal)) + len(image[0]) / 2 + cropLeft

    return [[int(leftPupilX), int(leftPupilY)], [int(rightPupilX), int(rightPupilY)]]


def locateMouth(image, pupils, cropLeft, cropTop):

    interOcularDistance = pupils[1][0] - pupils[0][0]
    pupilsTop = (pupils[0][1] + pupils[1][1]) / 2 - cropTop

    mouthRegion = image[interOcularDistance * 0.8 + pupilsTop:interOcularDistance * 1.8 + pupilsTop, :]

    mouthHistogramHorizontal, mouthHistogramVertical = calculateDeltaHistograms(mouthRegion)

    mouthY = mouthHistogramVertical.index(max(mouthHistogramVertical)) + pupilsTop + interOcularDistance * 0.8 + cropTop
    mouthX = (pupils[1][0] + pupils[0][0]) / 2

    return [int(mouthX), int(mouthY)]


def locateKeypoints():

    images = fmng.loadImages(593)
    globalError = []

    rejectedImages = 0

    for index, image in enumerate(images):

        print 'Processing [ %s : %s ]' % (index, len(images))

        currentImage, cropLeft, cropTop = locateFace(image)

        if currentImage is -1:
            pass
            rejectedImages += 1
        else:
            pupils = locatePupils(currentImage, cropLeft, cropTop)
            mouth = locateMouth(currentImage, pupils, cropLeft, cropTop)
            keypoints = [pupils[0], pupils[1], mouth]
            fmng.writeDetectedKeypoints(index, keypoints)
            fmng.writeCropPoints(index, [cropLeft, cropTop, len(currentImage[0]), len(currentImage)])
            localError = error.keypointDetectionErrorRate(image, index, keypoints)
            if localError[0] <= 10 and localError[1] <= 10 and localError[2] <= 10:
                globalError.append(localError)
                images[index] = currentImage
                if plot:
                    render.landmarks(currentImage, keypoints, 255, cropLeft, cropTop)
            else:
                 rejectedImages += 1

    print 'Rejection: %s out of %s' % (rejectedImages, len(images))

    if plot:
        render.error(globalError)

if __name__ == '__main__':
    locateKeypoints()
