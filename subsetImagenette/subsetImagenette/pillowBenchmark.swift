//
//  pillowBenchmark.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-03.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

import Foundation
import TensorFlow
import PythonKit

let random = Python.import("random")
let glob = Python.import("glob")
let pilImage = Python.import("PIL.Image")
let np = Python.import("numpy")
let pil = Python.import("PIL")

func getTensor(fromPath: String) -> (Tensor<Float>, Int32) {
    let img = pilImage.open(fromPath)
    let image = np.array(img, dtype: np.float32) * (1.0 / 255)
    var imageTensor = Tensor<Float>(numpy: image)!
    imageTensor = imageTensor.expandingShape(at: 0)
    imageTensor = _Raw.resizeArea(images: imageTensor , size: [160, 160])
    
    var label: Int32 = 0
    
    for i in 0..<10 {
        if fromPath.contains(classNames[i]) {
            label = Int32(i)
            break
        }
    }
    
    return (imageTensor, label)
}

func loadDataset(datasetType: String) -> (Tensor<Float>, [Int32]) {
    
    let fromList = glob.glob("/Users/ayushitiwari/Downloads/imagenette160New/\(datasetType)/*/**.JPEG")
    var labels: [Int32] = []
    let imagePath = String(fromList[0])!
    
    var imageTensor: Tensor<Float>
    
    let data = getTensor(fromPath: imagePath)
    imageTensor = data.0
    labels.append(data.1)
    
    for file in fromList[1..<fromList.count] {
        
        let imagePath = String(file) ?? ""
        let data = getTensor(fromPath: imagePath)
        let tensor = data.0
        labels.append(data.1)
        imageTensor = Tensor(concatenating: [imageTensor, tensor], alongAxis: 0)
        
    }
    return (imageTensor, labels)
}

func loadImagenetteTrainingFiles() -> (Tensor<Float>, [Int32]) {
    return loadDataset(datasetType: "train")
}

func loadImagenetteTestFiles() -> (Tensor<Float>, [Int32]) {
    return loadDataset(datasetType: "val")
}