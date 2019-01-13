//
//  ImgsConverter.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/15/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
import Foundation

class ImgsConverter {
    //
    // Convert String to base64
    //
    class func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //
    // Convert base64 to String
    //
    class func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
}
