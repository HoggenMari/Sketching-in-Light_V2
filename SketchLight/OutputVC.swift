//
//  OutputVC.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 02.09.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit

class OutputVC: UIViewController {
    
    
    @IBOutlet var uiimage: UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PlayerControlVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}
