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
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var longitudeTF: UITextField!
    @IBOutlet weak var gravityTF: UITextField!
    @IBOutlet weak var longitudeSlider: UISlider!
    @IBOutlet weak var gravitySlider: UISlider!
    
    var pendulumViewController: PendulumViewController?
    var pendulum: Pendulum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.layer.cornerRadius = 8
        
        longitudeTF.text = String(format: "%.1f", pendulum!.longitude)
        gravityTF.text = String(format: "%.1f", pendulum!.gravity)
        longitudeSlider.value = Float(pendulum!.longitude / Constants.MaxLongitudeValue)
        gravitySlider.value = Float(pendulum!.gravity / Constants.MaxGravityValue)
    }
    
    @IBAction func longitudeValueChanged(_ sender: UISlider) {
        let newValue = round((Constants.MaxLongitudeValue - 0.1) * CGFloat(sender.value) * 10) / 10 + 0.1
        longitudeTF.text = String(format: "%.1f", newValue)
    }
    
    @IBAction func gravityValueChanged(_ sender: UISlider) {
        let newValue = round(Constants.MaxGravityValue * CGFloat(sender.value) * 10) / 10
        gravityTF.text = String(format: "%.1f", newValue)
    }

    @IBAction func saveVariableConfiguration(_ sender: UIButton) {
        let longitude = Float(longitudeTF.text!)!
        let gravity = Float(gravityTF.text!)!
        pendulumViewController?.updatePendulumVariables(longitude: longitude, gravity: gravity)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func resetDefaultValues(_ sender: UIButton) {
        longitudeTF.text = String(format: "%.1f", 0.7)
        gravityTF.text = String(format: "%.1f", 9.8)
        longitudeSlider.value = Float(0.7 / Constants.MaxLongitudeValue)
        gravitySlider.value = Float(9.8 / Constants.MaxGravityValue)
    }
}
