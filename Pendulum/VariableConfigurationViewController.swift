//
//  VariableConfigurationViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

protocol UpdatePendulumVariables {
    func updatePendulumVariables(longitude: Float, gravity: Float)
}

class VariableConfigurationViewController: UIViewController {

    @IBOutlet weak var longitudeTF: UITextField!
    @IBOutlet weak var gravityTF: UITextField!
    @IBOutlet weak var longitudeSlider: UISlider!
    @IBOutlet weak var gravitySlider: UISlider!
    
    var pendulumViewController: PendulumViewController?
    var pendulum: Pendulum?
    let maxLongitudeValue: Float = 1.0
    let maxGravityValue: Float = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longitudeTF.text = String(pendulum!.longitude)
        gravityTF.text = String(pendulum!.gravity)
        longitudeSlider.value = pendulum!.longitude / maxLongitudeValue
        gravitySlider.value = pendulum!.gravity / maxGravityValue
    }
    
    @IBAction func longitudeValueChanged(_ sender: UISlider) {
        let newValue = round((maxLongitudeValue - 0.1) * sender.value * 10) / 10 + 0.1
        longitudeTF.text = String(newValue)
    }
    
    @IBAction func gravityValueChanged(_ sender: UISlider) {
        let newValue = round(maxGravityValue * sender.value * 10) / 10
        gravityTF.text = String(newValue)
    }

    @IBAction func saveVariableConfiguration(_ sender: UIButton) {
        let longitude = Float(longitudeTF.text!)!
        let gravity = Float(gravityTF.text!)!
        pendulumViewController?.updatePendulumVariables(longitude: longitude, gravity: gravity)
        navigationController?.popViewController(animated: true)
    }

}