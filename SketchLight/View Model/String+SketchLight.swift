//
//  NSString+SketchLight.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 18.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation

extension String {
    
    func playbackTimeString(for milliSeconds: Int) -> String {
        let hours = (Int)(milliSeconds / (60 * 60 * 1000))
        let minutes = (Int)(milliSeconds / (60 * 1000)) % 60
        let seconds = (Int)(milliSeconds / 1000) % 60
        
        if hours > 0 {
            return String(format: "%td:%02td:%02td", arguments: [hours, minutes, seconds])
        } else {
            return String(format: "%td:%02td", arguments: [minutes, seconds])
        }

    }

}
