//
//  libjpegTurbo.h
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-15.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <turbojpeg.h>

//#define THROW_TJ(action)  THROW(action, tjGetErrorStr2(tjInstance))
//#define THROW_UNIX(action)  THROW(action, strerror(errno))
#define DEFAULT_SUBSAMP  TJSAMP_444
#define DEFAULT_QUALITY  95

tjscalingfactor *scalingFactors = NULL;
int numScalingFactors = 0;

DLLEXPORT unsigned char* tjJPEGLoadImage(const char *filename, int *width,
                                         int align, int *height, int *pixelFormat, int *inSubsamp,
                                         int flags) {
    
    tjscalingfactor scalingFactor = { 1, 1 };

    FILE *jpegFile = NULL;
    unsigned char *imgBuf = NULL, *jpegBuf = NULL;
    *pixelFormat = TJPF_UNKNOWN;
    tjhandle tjInstance = NULL;
    
    long size;
    int inColorspace;
    unsigned long jpegSize;
    /* Read the JPEG file into memory. */
    jpegFile = fopen(filename, "rb");
    fseek(jpegFile, 0, SEEK_END);
    size = ftell(jpegFile);
    fseek(jpegFile, 0, SEEK_SET);
    jpegSize = (unsigned long)size;
    jpegBuf = (unsigned char *)tjAlloc(jpegSize);
    
    fread(jpegBuf, jpegSize, 1, jpegFile);
    fclose(jpegFile);
    jpegFile = NULL;
    
    tjInstance = tjInitDecompress();
    tjDecompressHeader3(tjInstance, jpegBuf, jpegSize, width, height, inSubsamp, &inColorspace);
    
    int jpegWidth = TJSCALED(*width, scalingFactor);
    int jpegHeight = TJSCALED(*height, scalingFactor);
    width = &jpegWidth;
    height = &jpegHeight;
    
    *pixelFormat = TJPF_BGRX;
    imgBuf = (unsigned char *)tjAlloc(*width * *height * tjPixelSize[*pixelFormat]);
    tjDecompress2(tjInstance, jpegBuf, jpegSize, imgBuf, *width, 0, *height, *pixelFormat, flags);
    tjFree(jpegBuf);  jpegBuf = NULL;
    tjDestroy(tjInstance);  tjInstance = NULL;
    
    return imgBuf;
    
}
