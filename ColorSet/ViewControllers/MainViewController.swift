//
//  MainViewController.swift
//  ColorSet
//
//  Created by Никита Рыжкин on 06.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class MainViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorOfView = mainView.backgroundColor
        settingsVC.delegate = self
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        mainView.backgroundColor = UIColor(displayP3Red: red,
                                           green: green,
                                           blue: blue,
                                           alpha: 1)
    }
}
