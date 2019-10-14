//
//  PendulumViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class PendulumViewController: UIViewController, UpdatePendulumVariables {

    @IBOutlet weak var pendulumStringView: UIView!
    @IBOutlet weak var pendulumView: UIView!
    var pendulumObj = Pendulum()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pendulumStringView.center.x = self.view.center.x
        pendulumView.center.x = self.view.center.x
        pendulumView.layer.cornerRadius = pendulumView.frame.width / 2
    }
    
    func initialPendulumSetup() {
        
    }
    
    func updatePendulumView() {
        
    }
    
    func updatePendulumVariables(longitude: Float, gravity: Float) {
        self.pendulumObj.longitude = longitude
        self.pendulumObj.gravity = gravity
        updatePendulumView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! VariableConfigurationViewController
        destination.pendulum = pendulumObj
        destination.pendulumViewController = self
    }

}
