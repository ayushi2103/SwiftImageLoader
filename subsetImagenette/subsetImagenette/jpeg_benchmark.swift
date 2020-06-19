//
//  jpeg_benchmark.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-19.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

import Foundation
import JPEG
import TensorFlow

func decode(jpeg path:String) throws -> (Tensor<Float>)
{
    guard let image:JPEG.Data.Rectangular<JPEG.Common> = try .decompress(path: path)
    else
    {
        fatalError("failed to open file '\(path)'")
    }
    let rgb:[JPEG.RGB] = image.unpack(as: JPEG.RGB.self),
        _:(x:Int, y:Int) = image.size
    let width = image.size.x
    let height = image.size.y
    let flatData = rgb.flatMap{ [$0.r, $0.g, $0.b] }
    let loadedTensor = Tensor<Float>(shape: [Int(height), Int(width), 3], scalars: flatData)
    
    return loadedTensor 
}

func getJPEGTensor(fromPath: String) -> (Tensor<Float>, Int32) {
    var imageTensor = decode(jpeg: fromPath)
    let tensorSize: _TensorElementLiteral<Int32> = _TensorElementLiteral<Int32>(integerLiteral: Int32.IntegerLiteralType(Int(size!)!))
    imageTensor = imageTensor.expandingShape(at: 0)
    imageTensor = _Raw.resizeArea(images: imageTensor , size: [ tensorSize, tensorSize])
    
    var label: Int32 = 0
    
    for i in 0..<10 {
        if fromPath.contains(classNames[i]) {
            label = Int32(i)
            break
        }
    }
    
    return (imageTensor, label)
}

func loadJPEGDataset(datasetPaths: [String]) -> (Tensor<Float>, [Int32]) {
    
    //let fromList = glob.glob("/Users/ayushitiwari/Downloads/imagenette\(size!)New/\(datasetType)/*/**.JPEG")
    var labels: [Int32] = []
    //let imagePath = String(fromList[0])!
    
    var imageTensor: Tensor<Float>
    
    let data = getPILTensor(fromPath: datasetPaths[0])
    imageTensor = data.0
    labels.append(data.1)
    
    for path in datasetPaths[1..<datasetPaths.count] {
        
        //let imagePath = String(file) ?? ""
        let data = getPILTensor(fromPath: path)
        let tensor = data.0
        labels.append(data.1)
        imageTensor = Tensor(concatenating: [imageTensor, tensor], alongAxis: 0)
        
    }
    return (imageTensor, labels)
}

func loadImagenetteJPEGTrainingFiles() -> (Tensor<Float>, [Int32]) {
    return loadJPEGDataset(datasetPaths: try! getTrainPaths())
}

func loadImagenetteJPEGTestFiles() -> (Tensor<Float>, [Int32]) {
    return loadJPEGDataset(datasetPaths: try! getValPaths())
}

