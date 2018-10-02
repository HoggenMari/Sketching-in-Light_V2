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

enum ColorControlSlider {
    case brightness
    case red
    case blue
    case green
    
    static func typeFromString (_ string: String) -> ColorControlSlider? {
        switch string {
        case "Brightness":
            return .brightness
        case "Red":
            return .red
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return nil
        }
    }
    
    func stringValue() -> String {
        switch self {
        case .brightness:
            return "Brightness"
        case .red:
            return "Red"
        case .blue:
            return "Blue"
        case .green:
            return "Green"
        }
    }
}

class ControllerVC: UIViewController, MDCSliderDelegate {

    @IBOutlet var sliderStack: UIStackView!
    @IBOutlet var playerStack: UIStackView!
    
    @IBOutlet var controlBar: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    let defaultPadding: CGFloat = 8
    let sliderColorAlpha: CGFloat = 0.5
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PlayerControlVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inset = UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: defaultPadding, right: defaultPadding)
        self.additionalSafeAreaInsets = inset
        
        let label1 = UILabel()
        label1.text = ColorControlSlider.brightness.stringValue()
        label1.font = MDCTypography.body1Font()
        label1.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(label1)
        
        let slider1 = MDCSlider()
        slider1.addTarget(self,
                          action: #selector(didChangeSliderValue(senderSlider:)),
                         for: .valueChanged)
        slider1.accessibilityLabel = ColorControlSlider.brightness.stringValue()
        slider1.color = UIColor.white
        slider1.trackBackgroundColor = UIColor.white.withAlphaComponent(sliderColorAlpha)
        sliderStack.addArrangedSubview(slider1)
        
        let label2 = UILabel()
        label2.text = ColorControlSlider.red.stringValue()
        label2.font = MDCTypography.body1Font()
        label2.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(label2)
        
        let slider2 = MDCSlider()
        slider2.addTarget(self,
                          action: #selector(didChangeSliderValue(senderSlider:)),
                          for: .valueChanged)
        slider2.accessibilityLabel = ColorControlSlider.red.stringValue()
        slider2.color = UIColor.red
        slider2.trackBackgroundColor = UIColor.red.withAlphaComponent(sliderColorAlpha)
        sliderStack.addArrangedSubview(slider2)
        
        let label3 = UILabel()
        label3.text = ColorControlSlider.green.stringValue()
        label3.font = MDCTypography.body1Font()
        label3.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(label3)
        
        let slider3 = MDCSlider()
        slider3.addTarget(self,
                          action: #selector(didChangeSliderValue(senderSlider:)),
                          for: .valueChanged)
        slider3.accessibilityLabel = ColorControlSlider.green.stringValue()
        slider3.color = UIColor.green
        slider3.trackBackgroundColor = UIColor.green.withAlphaComponent(sliderColorAlpha)
        sliderStack.addArrangedSubview(slider3)
        
        let label4 = UILabel()
        label4.text = ColorControlSlider.blue.stringValue()
        label4.font = MDCTypography.body1Font()
        label4.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(label4)
        
        let slider4 = MDCSlider()
        slider4.addTarget(self,
                          action: #selector(didChangeSliderValue(senderSlider:)),
                          for: .valueChanged)
        slider4.accessibilityLabel = ColorControlSlider.blue.stringValue()
        slider4.color = UIColor.blue
        slider4.trackBackgroundColor = UIColor.blue.withAlphaComponent(sliderColorAlpha)
        sliderStack.addArrangedSubview(slider4)
        
        titleLabel.text = "Sehr langer text"
        titleLabel.font = MDCTypography.titleFont()
        
        //progressBar = MDCSlider()
        let progressSlider = MDCSlider()
        progressSlider.addTarget(self, action: #selector(didChangeSliderValue(senderSlider:)), for: .valueChanged)
        progressSlider.accessibilityLabel = "progress"
        progressSlider.color = UIColor.defaultButton
        progressSlider.trackBackgroundColor = UIColor.defaultButton.withAlphaComponent(sliderColorAlpha)
        progressSlider.thumbRadius = 0
        progressBar.addConstrained(subview: progressSlider)
        
        currentTimeLabel.font = MDCTypography.body2Font()
        currentTimeLabel.textColor = UIColor.defaultLabel
        totalTimeLabel.font = MDCTypography.body2Font()
        totalTimeLabel.textColor = UIColor.defaultLabel
        
        let playButton = UIButton()
        playButton.setIcon(icon: .googleMaterialDesign(.playArrow), iconSize: 25, color: .defaultButton, forState: .normal)
        playButton.setIcon(icon: .googleMaterialDesign(.pause), iconSize: 25, color: .defaultButton, forState: .selected)
        playButton.addTarget(self, action: #selector(playButtonTapped(senderButton:)), for: .touchUpInside)
        
        let skipPreviousButton = UIButton()
        skipPreviousButton.setIcon(icon: .googleMaterialDesign(.skipPrevious), iconSize: 25, color: .defaultButton, forState: .normal)
        let skipNextButton = UIButton()
        skipNextButton.setIcon(icon: .googleMaterialDesign(.skipNext), iconSize: 25, color: .defaultButton, forState: .normal)
        
        let repeatButton = UIButton()
        repeatButton.setIcon(icon: .googleMaterialDesign(.repeatIcon), iconSize: 25, color: UIColor.defaultButton.withAlphaComponent(0.5), forState: .normal)
        repeatButton.setTitleColor(UIColor.cyan, for: .selected)
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped(senderButton:)), for: .touchUpInside)

        let blurButton = UIButton()
        blurButton.setIcon(icon: .googleMaterialDesign(.blurOn), iconSize: 25, color: UIColor.defaultButton.withAlphaComponent(0.5), forState: .normal)
        blurButton.setTitleColor(UIColor.cyan, for: .selected)
        blurButton.addTarget(self, action: #selector(blurButtonTapped(senderButton:)), for: .touchUpInside)

        controlBar.addArrangedSubview(repeatButton)
        controlBar.addArrangedSubview(skipPreviousButton)
        controlBar.addArrangedSubview(playButton)
        controlBar.addArrangedSubview(skipNextButton)
        controlBar.addArrangedSubview(blurButton)

    }
    
    @objc func didChangeSliderValue(senderSlider:MDCSlider) {
        print("Did change slider value to: %@", senderSlider.value, senderSlider.accessibilityLabel ?? "")
        
    }
    
    @objc func playButtonTapped(senderButton:UIButton){
        senderButton.isSelected = !senderButton.isSelected
    }
    
    @objc func repeatButtonTapped(senderButton:UIButton){
        senderButton.isSelected = !senderButton.isSelected
    }
    
    @objc func blurButtonTapped(senderButton:UIButton){
        senderButton.isSelected = !senderButton.isSelected
    }
    
}
