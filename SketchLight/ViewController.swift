//
//  ViewController.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 02.09.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSlider

class ViewController: UIViewController {

    @IBOutlet var test: UIView!
    let output = ControllerVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*let slider = MDCSlider(frame: CGRect(x: 50, y: 50, width: 100, height: 27))
        slider.addTarget(self,
                         action: #selector(didChangeSliderValue(senderSlider:)),
                         for: .valueChanged)
        view.addSubview(slider)*/
        
        
        addChild(output)
        test.addSubview(output.view)
        test.addConstraint(NSLayoutConstraint(item: test, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 220))
        //output.view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        output.didMove(toParent: self)
        
    }
    
    override func viewWillLayoutSubviews() {
        output.view.frame = CGRect(x: 0, y: 0, width: test.bounds.width, height: test.bounds.height)
    }

    /*@objc func didChangeSliderValue(senderSlider:MDCSlider) {
        print("Did change slider value to: %@", senderSlider.value)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

