//
//  subsetImagenette160.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-05-31.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//  REFERENCE: https://github.com/Ayush517/imagenetteBenchmark.git
//

import Foundation
import TensorFlow
import PythonKit

let os = Python.import("os")
let osPath = Python.import("os.path")

let datasetPath = "/Users/ayushitiwari/Downloads/imagenette2-160"  // path of the original dataset
let savedImagePath = "/Users/ayushitiwari/Downloads/imagenette160New" // path of new dataset
var numberOfImages = 0  // number of images done

func imageDataset(datasetType: String, numImagesPerClass: Int32) -> PythonObject{
    
    random.seed(42) // randomizing using a seed
    //counter to count all the images
    var numberOfImages: Int32 = 0  // number of images done
    let imageList: PythonObject = []  // final new paths list
    
    for name in classNames[0..<10] {   // for each class in our dataset
        let path = datasetPath+"/\(datasetType)/\(name)"   // extract the folder of that class e.g. /Users/ayushitiwari/Downloads/imagenette2-160/train/n01440764
        
        let files = glob.glob(path+"/*.JPEG")   // get all images inside our class folder e.g. inside folder imagenette2-160/train/n01440764
        
        let newFolder = savedImagePath+"/\(datasetType)/\(name)"   // new folder of our subset e.g. /Users/ayushitiwari/Downloads/imagenette160New/train/n01440764
        
        numberOfImages = 0   // resetting number of images done in current class = 0
        
        for file in files {    // for all images inside our class folder e.g. inside folder imagenette2-160/train/n01440764
            
            do
            {    // create newFolder folder if not present e.g. create /Users/ayushitiwari/Downloads/imagenette160New/train/n01440764
                try FileManager.default.createDirectory(atPath: newFolder, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError
            {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
            
            let imagePath = String(file) ?? ""   // string path of a file e.g. "/Users/ayushitiwari/Downloads/imagenette2-160/train/n01440764/n01440764_6949.JPEG"
            let image = pilImage.open(imagePath)
            let filename = osPath.basename(imagePath)   // extract file name from imagePath e.g. "n01440764_6949.JPEG"
            let filePath = "\(newFolder)/\(filename)"
            // new path as which our image will be saved e.g. /Users/ayushitiwari/Downloads/imagenette160New/train/n01440764/n01440764_6949.JPEG
            
            if (Python.len(image.getbands()) == 3){   // if our image is RGB
                numberOfImages += 1     // increment number of images done in the current class
                image.save(filePath)    // save the image to new path e.g. /Users/ayushitiwari/Downloads/imagenette160New/train/n01440764/n01440764_6949.JPEG
                imageList.append(filePath)      // append this path to final paths list
            }
            
            if (numberOfImages == numImagesPerClass){    // if number of images done are equal to the number of images we want in a class
                break       // break
            }
        }
        
    }
    return imageList
    
}


