//
//  VideoPlayableItem.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 18.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation
import AVFoundation

class VideoPlayableItem: PlayableItem {
    
    let avPlayerItem: AVPlayerItem?
    let itemName: String?
    
    init(item: AVPlayerItem, name: String? = nil) {
        avPlayerItem = item
        itemName = name
    }
}
