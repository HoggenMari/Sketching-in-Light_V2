//
//  PlayerService.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 12.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation

class PlayerServices {

    static let sharedInstance = PlayerServices()

    public let player: Player

    private init() {
        player = VideoPlayer.init()
    }

    func currentPlayer() -> Player {
        return player
    }
}
