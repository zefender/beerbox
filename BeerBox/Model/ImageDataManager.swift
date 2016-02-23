
//
//  ImageDataManager.swift
//  VirtualTourist
//
//  Created by Кузяев Максим on 16.01.16.
//  Copyright © 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class ImageDataManager {
    private let directory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    
    func pathForFilename(filename: String) -> String {
        return directory.stringByAppendingPathComponent(filename)
    }
    
    func storeImageData(imageData: NSData, withFileName filename: String) {
        imageData.writeToFile(pathForFilename(filename), atomically: true)
    }
    
    func fetchImageWithFileName(filename: String) -> UIImage? {
        return UIImage(contentsOfFile: pathForFilename(filename))
    }

    func deletePhoto(filename: String) {
        do {
           try NSFileManager.defaultManager().removeItemAtPath(pathForFilename(filename))
        }  catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
