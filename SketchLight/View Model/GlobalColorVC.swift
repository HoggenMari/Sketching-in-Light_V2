//
//  GlobalColorVC.swift
//  SketchLight
//
//  Created by Marius Hoggenmueller on 03.10.18.
//  Copyright © 2018 Marius Hoggenmueller. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSlider
import MaterialComponents.MDCTypography

enum ColorControlSlider {
    case brightness
    case red
    case blue
    case green
    case none

    static func typeFromString (_ string: String) -> ColorControlSlider {
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
            return .none
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
        case .none:
            return "None"
        }
    }
}

protocol GlobalColorDelegate {
    func globalColorValueDidChange(for slider: ColorControlSlider, with value: CGFloat)
}

class GlobalColor: NSObject {
    
    static let sharedInstance: GlobalColor = GlobalColor()
    
    var globalColorDelegate: GlobalColorDelegate?

    var globalBrightness: CGFloat = 0.0 {
        didSet {
            if oldValue != globalBrightness {
                globalColorDelegate?.globalColorValueDidChange(for: .brightness, with: globalBrightness)
            }
        }
    }
    
    var globalRed: CGFloat = 0.0 {
        didSet {
            if oldValue != globalRed {
                globalColorDelegate?.globalColorValueDidChange(for: .red, with: globalRed)
            }
        }
    }
    
    var globalGreen: CGFloat = 0.0 {
        didSet {
            if oldValue != globalGreen {
                globalColorDelegate?.globalColorValueDidChange(for: .green, with: globalGreen)
            }
        }
    }
    
    var globalBlue: CGFloat = 0.0 {
        didSet {
            if oldValue != globalBlue {
                globalColorDelegate?.globalColorValueDidChange(for: .blue, with: globalBlue)
            }
        }
    }
}

class GlobalColorVC: UIViewController, MDCSliderDelegate {

    let sliderStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sliderStack.alignment = .fill
        sliderStack.axis = .vertical
        sliderStack.distribution = .fillEqually
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        sliderStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addConstrained(subview: sliderStack)

        let brightnessLabel = UILabel()
        brightnessLabel.text = ColorControlSlider.brightness.stringValue()
        brightnessLabel.font = MDCTypography.body1Font()
        brightnessLabel.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(brightnessLabel)

        let brightnessSlider = MDCSlider()
        brightnessSlider.addTarget(self,
                                   action: #selector(didChangeSliderValue(senderSlider:)),
                                   for: .valueChanged)
        brightnessSlider.accessibilityLabel = ColorControlSlider.brightness.stringValue()
        brightnessSlider.setValue(1, animated: false)
        brightnessSlider.color = UIColor.white
        brightnessSlider.trackBackgroundColor = UIColor.white.withAlphaComponent(UIColor.sliderColorAlpha)
        sliderStack.addArrangedSubview(brightnessSlider)

        let redColorLabel = UILabel()
        redColorLabel.text = ColorControlSlider.red.stringValue()
        redColorLabel.font = MDCTypography.body1Font()
        redColorLabel.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(redColorLabel)

        let redColorSlider = MDCSlider()
        redColorSlider.addTarget(self,
                                 action: #selector(didChangeSliderValue(senderSlider:)),
                                 for: .valueChanged)
        redColorSlider.accessibilityLabel = ColorControlSlider.red.stringValue()
        redColorSlider.color = UIColor.red
        redColorSlider.setValue(1, animated: false)
        redColorSlider.trackBackgroundColor = UIColor.red.withAlphaComponent(UIColor.sliderColorAlpha)
        sliderStack.addArrangedSubview(redColorSlider)

        let greenColorLabel = UILabel()
        greenColorLabel.text = ColorControlSlider.green.stringValue()
        greenColorLabel.font = MDCTypography.body1Font()
        greenColorLabel.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(greenColorLabel)

        let greenColorSlider = MDCSlider()
        greenColorSlider.addTarget(self,
                                   action: #selector(didChangeSliderValue(senderSlider:)),
                                   for: .valueChanged)
        greenColorSlider.accessibilityLabel = ColorControlSlider.green.stringValue()
        greenColorSlider.color = UIColor.green
        greenColorSlider.setValue(1, animated: false)
        greenColorSlider.trackBackgroundColor = UIColor.green.withAlphaComponent(UIColor.sliderColorAlpha)
        sliderStack.addArrangedSubview(greenColorSlider)

        let blueColorLabel = UILabel()
        blueColorLabel.text = ColorControlSlider.blue.stringValue()
        blueColorLabel.font = MDCTypography.body1Font()
        blueColorLabel.textColor = UIColor.defaultLabel
        sliderStack.addArrangedSubview(blueColorLabel)

        let blueColorSlider = MDCSlider()
        blueColorSlider.addTarget(self,
                                  action: #selector(didChangeSliderValue(senderSlider:)),
                                  for: .valueChanged)
        blueColorSlider.accessibilityLabel = ColorControlSlider.blue.stringValue()
        blueColorSlider.color = UIColor.blue
        blueColorSlider.setValue(1, animated: false)
        blueColorSlider.trackBackgroundColor = UIColor.blue.withAlphaComponent(UIColor.sliderColorAlpha)
        sliderStack.addArrangedSubview(blueColorSlider)
    }

    @objc func didChangeSliderValue(senderSlider: MDCSlider) {
        print("Did change slider value to: %@", senderSlider.value, senderSlider.accessibilityLabel ?? "")
        guard let slider = senderSlider.accessibilityLabel else {
            return
        }
        let sliderType = ColorControlSlider.typeFromString(slider)
        switch sliderType {
        case .brightness:
            GlobalColor.sharedInstance.globalBrightness = senderSlider.value
        case .red:
            GlobalColor.sharedInstance.globalRed = senderSlider.value
        case .green:
            GlobalColor.sharedInstance.globalGreen = senderSlider.value
        case .blue:
            GlobalColor.sharedInstance.globalBlue = senderSlider.value
        case .none:
            break
        }

    }

}
