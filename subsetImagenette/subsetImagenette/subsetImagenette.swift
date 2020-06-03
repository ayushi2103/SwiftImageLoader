//
//  subsetImagenette160.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-05-31.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//

import Foundation
import TensorFlow
import PythonKit

let random = Python.import("random")
let glob = Python.import("glob")
let os = Python.import("os")
let osPath = Python.import("os.path")
let pilImage = Python.import("PIL.Image")

let imagePath = "/Users/ayushitiwari/Downloads/imagenette2-160"
let savedImagePath = "/Users/ayushitiwari/Downloads/imagenette160New"
let image = pilImage.open(imagePath)
var numberOfImages = 0

func imageDataset(datasetType: String, numImagesPerClass: Int32) -> PythonObject{
    
    random.seed(42)
    //counter to count all the images
    var numberOfImages: Int32 = 0
    let imageList: PythonObject = []
    
    for name in classNames[0..<10] {
        let path = imagePath+"/\(datasetType)/\(name)"
        let files = glob.glob(path+"/*.JPEG")
        let imagePath = String(file) ?? ""
        
        for file in files {
            
            do
            {
                try FileManager.default.createDirectory(atPath: savedImagePath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError
            {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
            let filename = ospath.basename(imagePath)
            let filePath = "\(destinationPath)/\(filename)"
            
            if (Python.len(image.getbands()) == 3){
                numberOfImages += 1
                image.save(filePath)
                imageList.append(filePath)
            }
            
            if (numberOfImages == numImagesPerClass){
                break
            }
        }
        
    }
    return imageList
    
}


