//
//  PendulumViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit
import SpriteKit

class PendulumViewController: UIViewController, UpdatePendulumVariables, PendulumAngle {

    @IBOutlet weak var pendulumSKView: SKView!
    var pendulumScene: PendulumScene!
    
    @IBOutlet weak var reiniciarBtn: UIButton!
    @IBOutlet weak var configureVariablesBtn: UIButton!
    
    // Normal Timer Variables
    @IBOutlet weak var normalTimerView: UIView!
    @IBOutlet weak var normalTimerLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var angleLabel: UILabel!
    
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var playPausePendulumBtn: UIButton!
    
    var isNormalTimerPlaying = false
    var normalTimerCounter = 0
    var normalTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        
        pendulumSKView.ignoresSiblingOrder = true
        pendulumSKView.allowsTransparency = true
        
        DispatchQueue.main.async {
            self.pendulumScene = PendulumScene(size: CGSize(width: self.pendulumSKView.frame.width, height: self.pendulumSKView.frame.height))
            self.pendulumScene.pendulumViewController = self
            self.pendulumScene.scaleMode = .aspectFill
            
            self.pendulumSKView.presentScene(self.pendulumScene)
            self.pendulumScene.didMove(to: self.pendulumSKView)
            
            self.displayPeriod()
        }

    }
    
    func displayPeriod() {
        let period = String(format: "%.4f", pendulumScene.pendulum.getPeriod())
        periodLabel.text = "\(period) s"
    }

    
    func updatePendulumVariables(longitude: Float, gravity: Float) {
        pendulumScene.updateUserConfig(longitude: CGFloat(longitude), gravity: CGFloat(gravity))
        pendulumScene.didMove(to: pendulumSKView)
        
        displayPeriod()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! VariableConfigurationViewController
        destination.pendulum = pendulumScene.pendulum
        destination.pendulumViewController = self
    }
    
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
    
    @IBAction func dismissNC(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func resetPendulum(_ sender: UIButton) {
        pendulumScene.didMove(to: pendulumSKView)
        resetTimer()
    }
    
    func pendulumCurrAngle(degrees: Int) {
        angleLabel.text = String(degrees) + "º"
    }
    
    @IBAction func pausePendulum(_ sender: Any) {
        pendulumScene.pausedPendulum = !pendulumScene.pausedPendulum
        
        if pendulumScene.pausedPendulum {
            playPausePendulumBtn.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            playPausePendulumBtn.setImage(UIImage(systemName: "pause"), for: .normal)
        }
    }
    
    func setUpUI(){
        self.reiniciarBtn.layer.cornerRadius = 12
        self.configureVariablesBtn.layer.cornerRadius = 12
        
        let buttonFont = UIFont.boldSystemFont(ofSize: 15)
        self.reiniciarBtn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        self.reiniciarBtn.titleLabel?.adjustsFontForContentSizeCategory = true
        
        self.configureVariablesBtn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        self.configureVariablesBtn.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool { return false
    }
}
