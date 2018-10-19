//
//  OutputVC.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 02.09.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import AVFoundation

class OutputVC: UIViewController, ImageBufferDelegate, GlobalColorDelegate {

    var playerLayer: AVPlayerLayer!

    var imageView: UIImageView!
    
    var brightness: CGFloat = 1.0
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 1.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)

        if let player = PlayerServices.sharedInstance.currentPlayer() as? VideoPlayer {
            player.imageBufferDelegate = self
        }
        
        GlobalColor.sharedInstance.globalColorDelegate = self
    }

    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds
    }

    func newImageBuffer() {
        guard let player = PlayerServices.sharedInstance.currentPlayer() as? VideoPlayer else {
            return
        }
        guard let image = player.getImage() else {
            return
        }
        guard let colorMatrixFilter = CIFilter(name: "CIColorMatrix") else {
            imageView.image = UIImage(ciImage: image)
            return
        }
        colorMatrixFilter.setValue(image, forKey: kCIInputImageKey)
        colorMatrixFilter.setValue(CIVector(x: red, y: 0, z: 0, w: 0), forKey:
                "inputRVector")
        colorMatrixFilter.setValue(CIVector(x: 0, y: green, z: 0, w: 0), forKey:
                "inputGVector")
        colorMatrixFilter.setValue(CIVector(x: 0, y: 0, z: blue, w: 0), forKey:
                "inputBVector")
        guard let colorControlFilter = CIFilter(name: "CIColorControls"), let img = colorMatrixFilter.outputImage else {
            imageView.image = UIImage(ciImage: image)
            return
        }
        colorControlFilter.setValue(img, forKey: kCIInputImageKey)
        colorControlFilter.setValue(brightness - 1, forKey: kCIInputBrightnessKey)
        if let img = colorControlFilter.outputImage {
            imageView.image = UIImage(ciImage: img)
        }
    }

    func globalColorValueDidChange(for slider: ColorControlSlider, with value: CGFloat) {
        switch slider {
        case .brightness:
            brightness = value
        case .red:
            red = value
        case .green:
            green = value
        case .blue:
            blue = value
        case .none:
            break
        }
    }


}
