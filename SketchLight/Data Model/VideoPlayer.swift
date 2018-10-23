//
//  VideoPlayer.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 12.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import Foundation
import AVFoundation
import CoreImage
import CoreGraphics

class VideoPlayer: NSObject, Player {

    lazy var displayLink: CADisplayLink =
        CADisplayLink(target: self, selector: #selector(displayLinkDidRefresh(_:)))

    var playerDelegate: PlayerDelegate?

    var imageBufferDelegate: ImageBufferDelegate?

    var currentSketchId: Int = 0

    var currentSketchName: String = ""

    var currentSketchPosition: Int = 0

    var currentSketchLength: Int = 0

    var currentPlayerState: PlayerState = .playing

    var isPaused: Bool = false

    var isBuffering: Bool = false

    var isRepeatModeEnabled: Bool = true

    var isBackwardsEnabled: Bool = false

    var isSmoothEnabled: Bool = false

    var videoPlayer: AVPlayer? = nil {
        didSet {
            if oldValue != videoPlayer {
                setObservers()
            }
        }
    }

    var item: AVPlayerItem!

    let millisPerSecond: CGFloat = 1000

    var videoOutput: AVPlayerItemVideoOutput!

    var image: CIImage!

    let pixelBufferDict: [NSObject: AnyObject] =
        [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as AnyObject]

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: pixelBufferDict as? [String: Any])
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    private func setObservers() {
        videoPlayer!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.videoPlayer!.currentItem?.status == .readyToPlay {
                let time: Float64 = CMTimeGetSeconds(self.videoPlayer!.currentTime())
                self.currentSketchPosition = Int(Float (time))
                self.playerDelegate?.player(self, didChangeWith: PlayerEvent.progressChanged)
            }
        }
        videoPlayer?.addObserver(self, forKeyPath: "currentItem.status", options: [.old, .new], context: nil)

    }

    @objc func displayLinkDidRefresh(_ link: CADisplayLink) {
        let itemTime = videoOutput.itemTime(forHostTime: CACurrentMediaTime())
        if videoOutput.hasNewPixelBuffer(forItemTime: itemTime) {
            var presentationItemTime = CMTime.zero
            let pixelBuffer = videoOutput.copyPixelBuffer(forItemTime: itemTime, itemTimeForDisplay: &presentationItemTime)

            if let buffer = pixelBuffer {
                image = CIImage(cvPixelBuffer: buffer)
            }
            imageBufferDelegate?.newImageBuffer()
        }

    }

    @objc func playerItemDidPlayToEndTime(_ aNotification: NSNotification) {
        seek(to: 0)
        unpause()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.status" {
            if videoPlayer?.currentItem?.status == .readyToPlay {
                guard let videoItem = videoPlayer?.currentItem else {
                    return
                }
                let length = Float(CMTimeGetSeconds(videoItem.duration))
                if !length.isNaN {
                    currentSketchLength = Int(length) * Int(millisPerSecond)
                    let videoComposition = videoPlayer?.currentItem?.videoComposition
                    videoPlayer?.currentItem?.videoComposition = nil
                    videoPlayer?.currentItem?.videoComposition = videoComposition
                    videoPlayer?.currentItem?.add(videoOutput)
                    playerDelegate?.player(self, didChangeWith: PlayerEvent.trackInformationChanged)
                }
                
            }
        } else if keyPath == "playerItemDidPlayToEndTime" {
            seek(to: 0)
            videoPlayer?.play()
        }
    }

    func play(_ item: PlayableItem) {
        guard let videoItem = item as? VideoPlayableItem, videoItem.avPlayerItem != nil else {
            return
        }
        
        if videoPlayer == nil {
            videoPlayer = AVPlayer(playerItem: videoItem.avPlayerItem)
        } else {
            videoPlayer?.replaceCurrentItem(with: videoItem.avPlayerItem)
        }
        unpause()
        currentSketchName = videoItem.itemName ?? ""
        playerDelegate?.player(self, didChangeWith: PlayerEvent.trackInformationChanged)
        
    }

    func pause() {
        videoPlayer?.pause()
        self.playerDelegate?.player(self, didChangeWith: .playbackPaused)
    }

    func unpause() {
        videoPlayer?.play()
        self.playerDelegate?.player(self, didChangeWith: .playbackResumed)
    }

    func seek(to milliseconds: Int64) {
        guard let timeScale = videoPlayer?.currentItem?.duration.timescale else {
            return
        }
        let position: CMTime = CMTime(seconds: Double(milliseconds) / Double(millisPerSecond), preferredTimescale: timeScale)
        videoPlayer?.seek(to: position)
    }

    func getLayer() -> AVPlayerLayer {
        return AVPlayerLayer(player: videoPlayer)
    }

    func getImage() -> CIImage? {
        return image
    }

}
