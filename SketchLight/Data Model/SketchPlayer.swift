//
//  SketchPlayer.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 12.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation

class SketchPlayer: Player {

    var playerDelegate: PlayerDelegate?

    var imageBufferDelegate: ImageBufferDelegate?

    var currentSketchId: Int = 1

    var currentSketchName: String = "Test"

    var currentSketchPosition: Int = 0

    var currentSketchLength: Int = 0

    var currentPlayerState: PlayerState = .idle

    var isPaused: Bool = false

    var isBuffering: Bool = false

    var isRepeatModeEnabled: Bool = true

    var isBackwardsEnabled: Bool = true

    var isSmoothEnabled: Bool = true

    init() {

    }

    func play(_ item: PlayableItem) {
        // do nothing
    }

    func pause() {
        // do nothing
    }

    func unpause() {
        // do nothing
    }

    func seek(to milliseconds: Int64) {
        // do nothing
    }

}
