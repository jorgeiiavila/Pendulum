//
//  PendulumScene.swift
//  Pendulum
//
//  Created by Fernando Salazar on 04/11/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import SpriteKit

protocol PendulumAngle {
    func pendulumCurrAngle(degrees: Int)
}

class PendulumScene: SKScene {
    
    private let line = SKShapeNode()
    private let circle = SKShapeNode(circleOfRadius: 40 )
    private var circleTouch: UITouch?
    var pendulum = Pendulum(longitude: Constants.DefaultLongitude, gravity: Constants.DefaultGravity)
    var pendulumViewController: PendulumViewController?
    
    var pausedPendulum = false
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = SKColor.clear
    }
    
    private func drawLine(from: CGPoint, to: CGPoint) {
        line.removeFromParent()
        let path = CGMutablePath()
        path.move(to: from)
        path.addLine(to: to)
        line.path = path
        
        if pendulumViewController?.traitCollection.userInterfaceStyle == .dark {
            line.strokeColor = SKColor.white
        } else {
            line.strokeColor = SKColor.black
        }
        
        self.addChild(line)
    }
    
    func drawPendulum() {
        circle.removeFromParent()
        circle.position = pendulum.getBobPosition()
        
        if pendulumViewController?.traitCollection.userInterfaceStyle == .dark {
            circle.strokeColor = SKColor.white
        } else {
            circle.strokeColor = SKColor.black
        }
        
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.systemPink
        self.addChild(circle)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if circleTouch == nil && !pausedPendulum {
            pendulum.movePendulum()
        }
        
        drawLine(from: pendulum.getLineOrigin(), to: pendulum.getBobPosition())
        drawPendulum()
    }
    
    override func didMove(to view: SKView) {
        pendulum.initPendulum(originX: view.frame.width / 2, originY: view.frame.height, bobX: view.frame.width / 2, bobY: view.frame.height - pendulum.pixels())
        pendulumViewController?.pendulumCurrAngle(degrees: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if atPoint(touch.location(in: self)) == circle {
                circleTouch = touch
                pendulum.resetMovement()
            }
        }
    }
    
    // Check if the touch event that is moving is the one that anchored the circle to our finger, if yes, move the circle to the position of the finger.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if circleTouch != nil && touch as UITouch == circleTouch! {
                let location = touch.location(in: self)
                let wasMoved = pendulum.movePendulumWithTouch(location: location)
                
                if wasMoved {
                    pendulumViewController?.pendulumCurrAngle(degrees: pendulum.degrees())
                }
            }
        }
    }
    
    // Clean up the touch event when the finger anchoring the circle is raised from the screen.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if circleTouch != nil && touch as UITouch == circleTouch!{
                circleTouch = nil
//                startedMoving = true
            }
        }
    }
    
    func updateUserConfig(longitude: CGFloat, gravity: CGFloat) {
        pendulum.setUserConfig(longitude: longitude, gravity: gravity)
    }
}
