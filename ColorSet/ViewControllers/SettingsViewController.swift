//
//  SettingsViewController.swift
//  ColorSet
//
//  Created by Никита Рыжкин on 06.11.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var coloredView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var colorOfView: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coloredView.backgroundColor = colorOfView
        
        coloredView.layer.cornerRadius = 10
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        let colorOfViewCI = colorOfView.coreImageColor
        
        redSlider.value = Float(colorOfViewCI.red)
        greenSlider.value = Float(colorOfViewCI.green)
        blueSlider.value = Float(colorOfViewCI.blue)
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)

        redTF.text = string(from: redSlider)
        greenTF.text = string(from: greenSlider)
        blueTF.text = string(from: blueSlider)

    }
    
    @IBAction func rgbSliderPressed(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTF.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTF.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTF.text = string(from: blueSlider)
        }
        setColor()
    }
    @IBAction func doneButtonPressed() {
        delegate.setColor(red: CGFloat(redSlider.value ),
                          green: CGFloat(greenSlider.value),
                          blue: CGFloat(blueSlider.value))
        dismiss(animated: true)
    }
    
    private func setColor() {
        coloredView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let textFieldValue = Float(textField.text!) else {
            do {showAlert(title: "Value is empty",
                          message: "Please enter the value",
                          textField: nil); return }}
        guard textFieldValue >= 0 && textFieldValue <= 1 else {
            do {showAlert(title: "Value is not correct",
                          message: "Please, enter correct value",
                          textField: nil); return }}
        switch textField {
        case redTF:
            redLabel.text = textField.text
            redSlider.value = Float(textFieldValue)
        case greenTF:
            greenLabel.text = textField.text
            greenSlider.value = Float(textFieldValue)
        default:
            blueLabel.text = textField.text
            blueSlider.value = Float(textFieldValue)
        }
        setColor()
        }
}

extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

