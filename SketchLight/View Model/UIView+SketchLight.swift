//
//  UIView+SketchLight.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 03.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
