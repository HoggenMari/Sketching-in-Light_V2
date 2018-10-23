//
//  AssetManager.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 23.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation
import Photos

class AssetManager {
    
    var images: [PHAsset]! = []
    var videos: [PHAsset]! = []

    init() {
        fetchImages()
        fetchVideos()
    }
    
    private func fetchImages() {
        let result = PHAsset.fetchAssets(with: .image, options: nil)
        result.enumerateObjects({ [unowned self] (asset, index, stop) -> Void in
            self.images.append(asset)
        })
    }
    
    private func fetchVideos() {
        let result = PHAsset.fetchAssets(with: .video, options: nil)
        result.enumerateObjects({ [unowned self] (asset, index, stop) -> Void in
            self.videos.append(asset)
        })
    }
    
    
}
