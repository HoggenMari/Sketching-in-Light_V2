//
//  VideoGalleryVC.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 23.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation
import UIKit
import Photos

class VideoGalleryVC: GalleryVC {
    
    private var cells = AssetManager().videos
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reusableIdentifier, for: indexPath)
        
        if let cell = cell as? ImageCell, indexPath.row < cells!.count {
            let item = cells![indexPath.row]
            cell.imageView.image = getThumbnailFrom(asset: item)
            cell.label.text = String().playbackTimeString(for: Int(item.duration * 1000))
            cell.selectedBackgroundView = UIView(frame: cell.frame)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < cells!.count else { return }
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let item = cells![indexPath.row]

        PHCachingImageManager().requestAVAsset(forVideo: item, options: nil) { (asset, audioMix, args) in
            let asset = asset as! AVURLAsset
            
            DispatchQueue.main.async {
                let item = AVPlayerItem(url: asset.url)
                let videoItem = VideoPlayableItem(item: item, name: asset.url.lastPathComponent)
                PlayerServices.sharedInstance.currentPlayer().play(videoItem)
            }
        }
    
    }
    
    func getThumbnailFrom(asset: PHAsset) -> UIImage? {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 138, height: 138), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

    
    
}
