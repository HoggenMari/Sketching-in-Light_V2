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

class ViewController: UIViewController {

    @IBOutlet var controllerContainerView: UIView!
    @IBOutlet var outputContainerView: UIView!

    let controllerVC = ControllerVC()
    let outputVC = OutputVC()

    var gameTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(controllerVC)
        controllerContainerView.addSubview(controllerVC.view)
        controllerVC.didMove(toParent: self)

        addChild(outputVC)
        outputContainerView.addSubview(outputVC.view)
        outputVC.didMove(toParent: self)
        
        let urlPathString = Bundle.main.path(forResource: "index", ofType: "mp4")
        
        if let fileURL = urlPathString {
            let item = AVPlayerItem(url: URL(fileURLWithPath: fileURL))
            let videoItem = VideoPlayableItem(item: item)
            PlayerServices.sharedInstance.currentPlayer().play(videoItem)
        }

    }

    override func viewWillLayoutSubviews() {
        controllerVC.view.frame = CGRect(x: 0, y: 0, width: controllerContainerView.bounds.width, height: controllerContainerView.bounds.height)
        outputVC.view.frame = CGRect(x: 0, y: 0, width: outputContainerView.bounds.width, height: outputContainerView.bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

