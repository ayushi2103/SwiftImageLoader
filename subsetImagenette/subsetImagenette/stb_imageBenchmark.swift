//
//  stb_imageBenchmark.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-04.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

//import Foundation
//import TensorFlow
//import STBImage
//import PythonKit
//
//func getSTBTensor(fromPath: String) -> (Tensor<Float>, Int32) {
//    let img = pilImage.open(fromPath)
//    let image = np.array(img, dtype: np.float32) * (1.0 / 255)
//    var imageTensor = Tensor<Float>(numpy: image)!
//    let tensorSize: _TensorElementLiteral<Int32> = _TensorElementLiteral<Int32>(integerLiteral: Int32.IntegerLiteralType(Int(size!)!))
//    imageTensor = imageTensor.expandingShape(at: 0)
//    imageTensor = _Raw.resizeArea(images: imageTensor , size: [ tensorSize, tensorSize])
//    
//    var label: Int32 = 0
//    
//    for i in 0..<10 {
//        if fromPath.contains(classNames[i]) {
//            label = Int32(i)
//            break
//        }
//    }
//    
//    return (imageTensor, label)
//}
//
//func loadPILDataset(datasetPaths: [String]) -> (Tensor<Float>, [Int32]) {
//    
//    //let fromList = glob.glob("/Users/ayushitiwari/Downloads/imagenette\(size!)New/\(datasetType)/*/**.JPEG")
//    var labels: [Int32] = []
//    //let imagePath = String(fromList[0])!
//    
//    var imageTensor: Tensor<Float>
//    
//    let data = getPILTensor(fromPath: datasetPaths[0])
//    imageTensor = data.0
//    labels.append(data.1)
//    
//    for path in datasetPaths[1..<datasetPaths.count] {
//        
//        //let imagePath = String(file) ?? ""
//        let data = getPILTensor(fromPath: path)
//        let tensor = data.0
//        labels.append(data.1)
//        imageTensor = Tensor(concatenating: [imageTensor, tensor], alongAxis: 0)
//        
//    }
//    return (imageTensor, labels)
//}
//
//func loadImagenettePILTrainingFiles() -> (Tensor<Float>, [Int32]) {
//    return loadPILDataset(datasetPaths: try! getTrainPaths())
//}
//
//func loadImagenettePILTestFiles() -> (Tensor<Float>, [Int32]) {
//    return loadPILDataset(datasetPaths: try! getValPaths())
//}
//
