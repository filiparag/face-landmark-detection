#! /usr/bin/python

import cv2
import numpy as np
import matplotlib.pyplot as plt

def landmarks(imageFile, landmarks, color=255, cropLeft=0, cropTop=0):

    if isinstance(imageFile, basestring):
        image = cv2.imread(imageFile, 0)
    else:
        image = imageFile

    for landmark in landmarks:
        cv2.circle(image, (landmark[0] - cropLeft, landmark[1] - cropTop), 3, color, 2)

    cv2.imshow('Landmarks render', image)
    cv2.waitKey(0)


def image(imageFile):

    if isinstance(imageFile, basestring):
        image = cv2.imread(imageFile, 0)
    else:
        image = imageFile

    cv2.imshow('Image render', image)
    cv2.waitKey(0)

def error(errorRate):

    globalError = [[], [], []]

    for errorLine in errorRate:
        for it in range(0, 3):
            globalError[it].append(errorLine[it])

    plt.hist(globalError[2], label='Mouth center', fc=(0, 0, 1, 0.5), ls='dotted')
    plt.hist(globalError[0], label='Left Eye', fc=(0, 1, 0, 0.5), ls='dashed')
    plt.hist(globalError[1], label='Right Eye', fc=(1, 0, 0, 0.5))

    plt.xlabel('Error [px]')
    plt.ylabel('Samples')
    plt.legend()

    plt.show()

    gE = [[], [], []]

    for ig in range(0, 3):
        for it in range(0, len(globalError[ig])):
            if globalError[ig][it] < 25:
                gE[ig].append(globalError[ig][it])

    hist, bins = np.histogram(gE[0], bins=200)
    plt.plot(bins[:-1], np.cumsum(hist), label='Left Eye')
    hist, bins = np.histogram(gE[1], bins=200)
    plt.plot(bins[:-1], np.cumsum(hist), label='Right Eye')
    hist, bins = np.histogram(gE[2], bins=200)
    plt.plot(bins[:-1], np.cumsum(hist), label='Mouth center')

    plt.xlabel('Error [px]')
    plt.ylabel('Samples')
    plt.legend()

    plt.show()