//
//  Controller.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 03.09.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSlider
import MaterialComponents.MDCTypography
import SwiftIcons

class ControllerVC: UIViewController, MDCSliderDelegate, PlayerDelegate {

    @IBOutlet var globalControl: UIView!
    @IBOutlet var playerStack: UIStackView!

    @IBOutlet var controlBar: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIView!

    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    let defaultPadding: CGFloat = 8

    var player: Player!

    var progressSlider: MDCSlider!
    
    var playButton: UIButton!
    
    var backwardsButton: UIButton!

    var smoothButton: UIButton!

    var isSliding = false

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PlayerControlVC", bundle: nil)
        player = PlayerServices.sharedInstance.currentPlayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let inset = UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: defaultPadding, right: defaultPadding)
        self.additionalSafeAreaInsets = inset

        titleLabel.font = MDCTypography.titleFont()

        let globalColorVC = GlobalColorVC()
        addChild(globalColorVC)
        globalControl.addConstrained(subview: globalColorVC.view)
        globalColorVC.didMove(toParent: self)

        progressSlider = MDCSlider()
        progressSlider.addTarget(self, action: #selector(slidingDidBegin(senderSlider:)), for: .touchDown)
        progressSlider.addTarget(self, action: #selector(slidingDidEnd(senderSlider:)), for: .touchUpInside)
        progressSlider.addTarget(self, action: #selector(slidingDidEnd(senderSlider:)), for: .touchUpOutside)
        progressSlider.addTarget(self, action: #selector(sliderValueChanged(senderSlider:)), for: .valueChanged)
        progressSlider.accessibilityLabel = "progress"
        progressSlider.color = UIColor.defaultButton
        progressSlider.trackBackgroundColor = UIColor.defaultButton.withAlphaComponent(UIColor.sliderColorAlpha)
        progressSlider.thumbRadius = 10
        progressBar.addConstrained(subview: progressSlider)

        currentTimeLabel.font = MDCTypography.body2Font()
        currentTimeLabel.textColor = UIColor.defaultLabel
        totalTimeLabel.font = MDCTypography.body2Font()
        totalTimeLabel.textColor = UIColor.defaultLabel

        playButton = UIButton()
        playButton.setIcon(icon: .googleMaterialDesign(.playArrow), iconSize: 25, color: .defaultButton, forState: .normal)
        playButton.setIcon(icon: .googleMaterialDesign(.pause), iconSize: 25, color: .defaultButton, forState: .selected)
        playButton.addTarget(self, action: #selector(playButtonTapped(senderButton:)), for: .touchUpInside)

        backwardsButton = UIButton()
        backwardsButton.setIcon(icon: .googleMaterialDesign(.repeatIcon), iconSize: 25, color: UIColor.defaultButton.withAlphaComponent(0.5), forState: .normal)
        backwardsButton.setTitleColor(UIColor.cyan, for: .selected)
        backwardsButton.addTarget(self, action: #selector(backwardsButtonTapped(senderButton:)), for: .touchUpInside)

        smoothButton = UIButton()
        smoothButton.setIcon(icon: .googleMaterialDesign(.blurOn), iconSize: 25, color: UIColor.defaultButton.withAlphaComponent(0.5), forState: .normal)
        smoothButton.setTitleColor(UIColor.cyan, for: .selected)
        smoothButton.addTarget(self, action: #selector(smoothButtonTapped(senderButton:)), for: .touchUpInside)

        controlBar.addArrangedSubview(backwardsButton)
        controlBar.addArrangedSubview(playButton)
        controlBar.addArrangedSubview(smoothButton)

        updateUI()
        
        player.playerDelegate = self

    }

    @objc func slidingDidBegin(senderSlider: MDCSlider) {
        isSliding = true
        player?.pause()
        player?.seek(to: Int64(round(senderSlider.value * CGFloat(player.currentSketchLength))))
    }

    @objc func slidingDidEnd(senderSlider: MDCSlider) {
        isSliding = false
        player.unpause()
    }

    @objc func sliderValueChanged(senderSlider: MDCSlider) {
        player?.seek(to: Int64(round(senderSlider.value * CGFloat(player.currentSketchLength))))
    }

    @objc func playButtonTapped(senderButton: UIButton) {
        senderButton.isSelected = !senderButton.isSelected
        if senderButton.isSelected {
            player.unpause()
        } else {
            player.pause()
        }
    }

    @objc func backwardsButtonTapped(senderButton: UIButton) {
        if player.isBackwardsEnabled {
            senderButton.isSelected = !senderButton.isSelected
        }
    }

    @objc func smoothButtonTapped(senderButton: UIButton) {
        if player.isSmoothEnabled {
            senderButton.isSelected = !senderButton.isSelected
        }
    }

    private func updateProgress(_ position: CGFloat) {
        progressSlider.setValue(position, animated: false)
    }
    
    private func updateUI() {
        updateBackwardButton()
        updateBlurButton()
    }
    
    private func updateBackwardButton() {
        backwardsButton.alpha = player.isBackwardsEnabled ? 1.0 : 0.3
    }
    
    private func updateBlurButton() {
        smoothButton.alpha = player.isSmoothEnabled ? 1.0 : 0.3
    }

    func player(_ player: Player, didChangeWith playerEvent: PlayerEvent) {
        switch playerEvent {
        case .progressChanged:
            if !isSliding {
                updateProgress(CGFloat(player.currentSketchPosition * 1000) / CGFloat(player.currentSketchLength))
                currentTimeLabel.text = String().playbackTimeString(for: player.currentSketchPosition * 1000)
            }
        case .playbackResumed:
            playButton.isSelected = true
        case .playbackPaused:
            playButton.isSelected = false
        case .backwardsIsActivated, .backwardsIsDectivated:
            updateBackwardButton()
        case .smoothIsActivated, .smoothIsDectivated:
            updateBlurButton()
        case .trackInformationChanged:
            totalTimeLabel.text = String().playbackTimeString(for: player.currentSketchLength)
            titleLabel.text = player.currentSketchName
        default: break
        }
    }

}
