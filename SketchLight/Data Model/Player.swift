//
//  Player.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 08.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation

enum PlayerState {
    case inactive
    case idle
    case playing
}

enum PlayerEvent {
    case repeatIsActivated
    case repeatIsDeactivated
    case backwardsIsActivated
    case backwardsIsDectivated
    case smoothIsActivated
    case smoothIsDectivated
    case trackInformationChanged
    case progressChanged
    case playbackPaused
    case playbackResumed
    case playerStateChanged
}

protocol PlayerDelegate: class {
    func player(_ player: Player, didChangeWith playerEvent: PlayerEvent)
}

protocol ImageBufferDelegate: class {
    func newImageBuffer()
}

protocol Player {

    var playerDelegate: PlayerDelegate? { get set }

    var imageBufferDelegate: ImageBufferDelegate? { get set }

    var currentSketchId: Int { get }

    var currentSketchName: String { get }

    var currentSketchPosition: Int { get }

    var currentSketchLength: Int { get }

    var currentPlayerState: PlayerState { get }

    var isPaused: Bool { get }

    var isBuffering: Bool { get }

    var isRepeatModeEnabled: Bool { get }

    var isBackwardsEnabled: Bool { get }

    var isSmoothEnabled: Bool { get }

    func play(_ item: PlayableItem)

    func pause()

    func unpause()

    func seek(to milliseconds: Int64)
}
