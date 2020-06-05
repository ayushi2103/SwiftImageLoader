//
//  ImagePathRetrieval.swift
//  subsetImagenette
//
//  Created by Ayushi Tiwari on 2020-06-04.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//  REFERENCE: https://github.com/tensorflow/swift-models/blob/master/Datasets/Imagenette/Imagenette.swift
//  REFERENCE: https://github.com/Ayush517/imagenetteBenchmark.git
//

import Foundation
import ModelSupport
import TensorFlow
import Batcher
import Datasets

func getURLS(datasetType: String) throws -> [URL] {
    let path = "\(newDatasetPath)/\(datasetType)"
    let url = URL(string: path)!
    let dirContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles])
    var urls: [URL] = []
    for directoryURL in dirContents {
        let subdirContents = try FileManager.default.contentsOfDirectory(
            at: directoryURL, includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])
        urls += subdirContents
    }
    return urls
}

func getFolderURLS(datasetType: String) throws -> [URL] {
   let path = "\(newDatasetPath)/\(datasetType)"
    let url = URL(string: path)!
    let dirContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles])
    return dirContents
}

func parentLabel(url: URL) -> String {
    return url.deletingLastPathComponent().lastPathComponent
}

func parentLabelFromFolder(url: URL) -> String {
    return url.lastPathComponent
}

func createLabelDict(urls: [URL]) -> [String: Int] {
    let allLabels = urls.map(parentLabelFromFolder)
    let labels = Array(Set(allLabels)).sorted()
    return Dictionary(uniqueKeysWithValues: labels.enumerated().map{ ($0.element, $0.offset) })
}

func getTrainPaths() throws -> [String] {
    let urls = try getURLS(datasetType: "train")
    let trainPaths = urls.map{$0.absoluteString.components(separatedBy: "//")[1]}
    return trainPaths
}

func getValPaths() throws -> [String] {
    let urls = try getURLS(datasetType: "val")
    let valPaths = urls.map{$0.absoluteString.components(separatedBy: "//")[1]}
    return valPaths
}
