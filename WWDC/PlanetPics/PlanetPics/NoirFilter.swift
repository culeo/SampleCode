//
//  NoirFilter.swift
//  PlanetPics
//
//  Created by Leo on 2019/6/27.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit

class NoirFilter {
    
    let name: String = "Noir"
    
    func apply(image: UIImage) -> UIImage? {
        
        var filteredImage: UIImage? = nil
        if let ci = CIImage(image: image) {
            let rect = CGRect(origin: CGPoint.zero, size: image.size)
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
            
            if let quartzContext = UIGraphicsGetCurrentContext() {
                let ciContext = CIContext(cgContext: quartzContext, options: nil)
                if let filter = CIFilter(name: "CIPhotoEffectNoir", parameters: [kCIInputImageKey: ci as Any]),
                    let outputImage = filter.outputImage,
                    let cgImage = ciContext.createCGImage(outputImage, from: rect) {
                    
                    let noirImage = UIImage(cgImage: cgImage)
                    if let pngData = noirImage.pngData() {
                        filteredImage = UIImage(data: pngData)
                    }
                }
            }
            
            UIGraphicsEndImageContext()
        }
        
        return filteredImage
    }
}
