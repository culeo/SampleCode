//
//  ViewController.swift
//  PlanetPics
//
//  Created by Leo on 2019/6/27.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var imageView: UIImageView?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 50))
        button.center = self.view.center
        button.setTitle("Use Filter", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        self.imageView = UIImageView.init(frame: self.view.frame)
        if let imageView = self.imageView {
            imageView.isHidden = true
            imageView.contentMode = .scaleAspectFill
            self.view.addSubview(imageView)
        }
    }
    
    /*
    @objc func applyFilter() {
        let filter = NoirFilter()
        let queue = DispatchQueue.global(qos: .utility)
        let maxSize = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

        queue.async {
            var filteredImage: UIImage? = nil
            if let imageURL = Bundle.main.url(forResource: "wallhaven", withExtension: "jpg") {
                if let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil) {
                    let options: [NSString: Any] = [
                        kCGImageSourceThumbnailMaxPixelSize: maxSize,
                        kCGImageSourceCreateThumbnailFromImageAlways: true
                    ]
                    if let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) {
                        let image = UIImage(cgImage: scaledImage)
                        filteredImage = filter.apply(image: image)
                    }
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }
                sSelf.imageView?.image = filteredImage
                sSelf.imageView?.isHidden = false
            }
        }
    } */

    @objc func applyFilter() {
        let filter = NoirFilter()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            var filteredImage: UIImage? = nil
            if let imageURL = Bundle.main.url(forResource: "wallhaven", withExtension: "jpg"),
                let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data) {
                filteredImage = filter.apply(image: image)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }
                sSelf.imageView?.image = filteredImage
                sSelf.imageView?.isHidden = false
            }
        }
    }
}

