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
    @IBOutlet weak var configureVariablesBtn: UIButton!
    
    // Normal Timer Variables
    @IBOutlet weak var normalTimerView: UIView!
    @IBOutlet weak var normalTimerLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    var isNormalTimerPlaying = false
    var normalTimerCounter = 0
    var normalTimer = Timer()
    
    var pendulumObj = Pendulum()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pendulumStringView.center.x = self.view.center.x
        pendulumView.center.x = self.view.center.x
        pendulumView.layer.cornerRadius = pendulumView.frame.width / 2
        
        configureVariablesBtn.layer.cornerRadius = 8
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
    
    // Normal Timer Actions
    @objc func updateNormalTimer() {
        normalTimerCounter += 1
        let milliseconds = normalTimerCounter % 100
        let seconds = (normalTimerCounter / 100) % 60
        let minutes = (normalTimerCounter / 100) / 60
        let formattedStr = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
        normalTimerLabel.text = formattedStr
    }
    
    @IBAction func startPauseNormalTimer(_ sender: UIButton) {
        if isNormalTimerPlaying {
            isNormalTimerPlaying = false
            playPauseBtn.setImage(UIImage(systemName: "play"), for: .normal)
            normalTimer.invalidate()
        } else {
            isNormalTimerPlaying = true
            playPauseBtn.setImage(UIImage(systemName: "pause"), for: .normal)
            playPauseBtn.imageView?.image = UIImage(named: "pause")
            normalTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateNormalTimer), userInfo: nil, repeats: true)
        }
    }

    @IBAction func resetTimer(_ sender: UIButton) {
        resetTimer()
    }
    
    func resetTimer() {
        isNormalTimerPlaying = false
        playPauseBtn.setImage(UIImage(systemName: "play"), for: .normal)
        normalTimer.invalidate()
        normalTimerLabel.text = "00:00:00"
        normalTimerCounter = 0
    }
    
    @IBAction func showHideNormalTimer(_ sender: UISwitch) {
        resetTimer()
        normalTimerView.isHidden = !sender.isOn
    }
}
