//
//  stb_imageBenchmark.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-04.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

import Foundation
import TensorFlow
@_implementationOnly import STBImage
import PythonKit

func getSTBTensor(fromPath: URL) -> (Tensor<Float>, Int32) {
    let Imagesize: Int = Int(size ?? "") ?? 0
//print(Imagesize)
    let img = Image(jpeg: fromPath)
    let imgTensor = img.resized(to: (Imagesize, Imagesize)).tensor
    var imageTensor = imgTensor / 255.0
    let label: Int32 = Int32(unwrappedLabelDict[parentLabel(url: fromPath)]!)
    imageTensor = imageTensor.reshaped(to: [1, Imagesize, Imagesize, 3])
    
    return (imageTensor, label)
}

func loadSTBDataset(datasetPaths: [URL]) -> (Tensor<Float>, [Int32]) {
    
    //let fromList = glob.glob("/Users/ayushitiwari/Downloads/imagenette\(size!)New/\(datasetType)/*/**.JPEG")
    var labels: [Int32] = []
    //let imagePath = String(fromList[0])!
    
    var imageTensor: Tensor<Float>
    
    let data = getSTBTensor(fromPath: datasetPaths[0])
    imageTensor = data.0
    labels.append(data.1)
    
    for path in datasetPaths[1..<datasetPaths.count] {
        
        //let imagePath = String(file) ?? ""
        let data = getSTBTensor(fromPath: path)
        let tensor = data.0
        labels.append(data.1)
        imageTensor = Tensor(concatenating: [imageTensor, tensor], alongAxis: 0)
        
    }
    return (imageTensor, labels)
}

func loadImagenetteSTBTrainingFiles() -> (Tensor<Float>, [Int32]) {
    return loadSTBDataset(datasetPaths: try! getURLS(datasetType: "train"))
}

func loadImagenetteSTBTestFiles() -> (Tensor<Float>, [Int32]) {
    return loadSTBDataset(datasetPaths: try! getURLS(datasetType: "val"))
}

