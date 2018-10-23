//
//  ViewController.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 02.09.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSlider
import AVFoundation
import Photos

class ViewController: UIViewController {

    @IBOutlet var controllerContainerView: UIView!
    @IBOutlet var outputContainerView: UIView!
    @IBOutlet var toolsContainerView: UIView!
    
    let controllerVC = ControllerVC()
    let outputVC = OutputVC()
    let galleryVC: VideoGalleryVC = VideoGalleryVC()

    var gameTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(controllerVC)
        controllerContainerView.addSubview(controllerVC.view)
        controllerVC.didMove(toParent: self)

        addChild(outputVC)
        outputContainerView.addSubview(outputVC.view)
        outputVC.didMove(toParent: self)
        
        addChild(galleryVC)
        toolsContainerView.addSubview(galleryVC.view)
        galleryVC.didMove(toParent: self)
        

    }

    override func viewWillLayoutSubviews() {
        controllerVC.view.frame = CGRect(x: 0, y: 0, width: controllerContainerView.bounds.width, height: controllerContainerView.bounds.height)
        outputVC.view.frame = CGRect(x: 0, y: 0, width: outputContainerView.bounds.width, height: outputContainerView.bounds.height)
        galleryVC.view.frame = CGRect(x: 0, y: 0, width: toolsContainerView.bounds.width, height: toolsContainerView.bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

