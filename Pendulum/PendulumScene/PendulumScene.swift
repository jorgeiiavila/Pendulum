//
//  PendulumScene.swift
//  Pendulum
//
//  Created by Fernando Salazar on 04/11/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import SpriteKit
 
class PendulumScene: SKScene {

    private var line = SKShapeNode()
    private let circle = SKShapeNode(circleOfRadius: 40 )
    
    private var originX: CGFloat = 0.0
    private var originY: CGFloat = 0.0
    private var bobX: CGFloat = 0.0
    private var bobY: CGFloat = 0.0
    
    private var _longitude: CGFloat = 200
    var longitude: CGFloat {
        get { return self._longitude }
        set { self._longitude = newValue }
    }
    
    private var _gravity: Double = 9.8
    var gravity: Double {
        get { return self._gravity }
        set { self._gravity = newValue }
    }
    
    private var angle: CGFloat = 0.0
    private var aAcc: CGFloat = 0.0
    private var aVel: CGFloat = 0.0
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = SKColor.white
    }
    
    private func drawLine(from: CGPoint, to: CGPoint) {
        line.removeFromParent()
        
        let path = CGMutablePath()
        path.move(to: from)
        path.addLine(to: to)
        
        line = SKShapeNode(path: path)
        line.strokeColor = SKColor.black
        
        self.addChild(line)
    }
    
    private func drawCircle() {
        circle.removeFromParent()
        
        circle.position = CGPoint(x: bobX, y: bobY)
        circle.fillColor = SKColor.orange
        
        self.addChild(circle)
    }
    
    override func update(_ currentTime: TimeInterval) {
        bobX = originX + longitude * sin(angle)
        bobY = originY - longitude * cos(angle)
            
        drawLine(from: CGPoint(x: originX, y: originY), to: CGPoint(x: bobX, y: bobY))
        drawCircle()
            
        aAcc = -0.01 * sin(angle)
        angle += aVel
        aVel += aAcc
        aVel *= 0.99
    }
    
    override func didMove(to view: SKView) {
        startPendulum(to: view)
    }
    
    func startPendulum(to view: SKView) {
        originX = view.frame.width / 2
        originY = view.frame.height
        
        bobX = view.frame.width / 2
        bobY = view.frame.height - longitude
        
        angle = CGFloat.pi / 6
    }
}
