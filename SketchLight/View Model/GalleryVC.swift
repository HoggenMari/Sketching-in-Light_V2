//
//  GalleryVC.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 23.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTypography


class GalleryVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var layout: UICollectionViewFlowLayout!
    let defaultPadding: CGFloat = 8

    init() {
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)

        super.init(collectionViewLayout: layout)
        
        self.collectionView.contentInset = UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: defaultPadding, right: defaultPadding)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reusableIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layout.itemSize
    }

    
}

class ImageCell: UICollectionViewCell {
    static let reusableIdentifier = "ImageCell"
    
    override var reuseIdentifier: String? {
        return ImageCell.reusableIdentifier
    }
    
    var imageView: UIImageView
    var label: UILabel

    
    override init(frame: CGRect) {
        
        self.imageView = UIImageView()
        self.label = UILabel()
        super.init(frame: frame)

        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))

        label.backgroundColor = .clear
        label.textColor = .white
        label.font = MDCTypography.body2Font()
        label.textColor = UIColor.defaultLabel
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -2))
        addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -4))

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
