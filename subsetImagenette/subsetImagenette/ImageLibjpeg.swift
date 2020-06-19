//
//  ImageLibjpeg.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-19.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

import Foundation
@_implementationOnly import SwiftLibjpegturbo
import TensorFlow
import ModelSupport
import libjpegturbo

public struct ImageJpegturbo {
    public enum ByteOrdering {
        case bgr
        case rgb
    }
    
    public enum Colorspace {
        case rgb
        case grayscale
    }
    
    enum ImageTensor {
        case float(data: Tensor<Float>)
        case uint8(data: Tensor<UInt8>)
    }
    
    let imageData: ImageTensor
    
    public var tensor: Tensor<Float> {
        switch self.imageData {
        case let .float(data): return data
        case let .uint8(data): return Tensor<Float>(data)
        }
    }
    
    public init(tensor: Tensor<UInt8>) {
        self.imageData = .uint8(data: tensor)
    }
    
    public init(tensor: Tensor<Float>) {
        self.imageData = .float(data: tensor)
    }
    
    public init(jpeg url: URL, byteOrdering: ByteOrdering = .rgb) {
        if byteOrdering == .bgr {
            // TODO: Add BGR byte reordering.
            fatalError("BGR byte ordering is currently unsupported.")
        } else {
            guard FileManager.default.fileExists(atPath: url.path) else {
                // TODO: Proper error propagation for this.
                fatalError("File does not exist at: \(url.path).")
            }
            
            var width: Int32 = 0
            var height: Int32 = 0
            var bpp: Int32 = 0
            var inSubsamp: Int32 = 0
            guard let bytes = tjJPEGLoadImage(url.path, &width, 0, &height, &bpp, &inSubsamp, 0)
            else {
                // TODO: Proper error propagation for this.
                fatalError("Unable to read image at: \(url.path).")
            }
            
            let data = [UInt8](UnsafeBufferPointer(start: bytes, count: Int(width * height * bpp)))
            var loadedTensor = Tensor<UInt8>(
                    shape: [Int(height), Int(width), Int(bpp)], scalars: data)
            if bpp == 1 {
                loadedTensor = loadedTensor.broadcasted(to: [Int(height), Int(width), 3])
            }
            self.imageData = .uint8(data: loadedTensor)
        }

    }
    
    public func resized(to size: (Int, Int)) -> ImageJpegturbo {
        switch self.imageData {
        case let .uint8(data):
            let resizedImage = resize(images: Tensor<Float>(data), size: size, method: .bilinear)
            return ImageJpegturbo(tensor: Tensor<UInt8>(resizedImage))
        case let .float(data):
            let resizedImage = resize(images: data, size: size, method: .bilinear)
            return ImageJpegturbo(tensor: resizedImage)
        }
    }

}
