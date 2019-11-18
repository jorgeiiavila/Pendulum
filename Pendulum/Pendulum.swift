//
//  Pendulum.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class Pendulum: NSObject {
    private var originX: CGFloat = 0.0
    private var originY: CGFloat = 0.0
    private var bobX: CGFloat = 0.0
    private var bobY: CGFloat = 0.0
    private var _longitude: CGFloat = Constants.DefaultLongitude // Longitude of the pendulum in meters
    var longitude: CGFloat {
        get { return self._longitude }
        set { self._longitude = newValue }
    }
    private var _gravity: CGFloat = Constants.DefaultGravity // Gravity of the system in m/s2
    var gravity: CGFloat {
        get { return self._gravity }
        set { self._gravity = newValue }
    }
    private var angle: CGFloat = 0.0 // Angle in radians
    private var aAcc: CGFloat = 0.0
    private var aVel: CGFloat = 0.0
    
    
    override init() {
        _longitude = Constants.DefaultLongitude
        _gravity = Constants.DefaultGravity
    }
    
    init(longitude: CGFloat, gravity: CGFloat) {
        super.init()
        self._longitude = longitude
        self._gravity = gravity
    }
    
    init(longitude: CGFloat, gravity: CGFloat, originX: CGFloat, originY: CGFloat, bobX: CGFloat, bobY: CGFloat) {
        super.init()
        self._longitude = longitude
        self._gravity = gravity
        initPendulum(originX: originX, originY: originY, bobX: bobX, bobY: bobY)
    }
    
    func getPeriod() -> CGFloat {
        return 2 * CGFloat.pi * sqrt(self._longitude/self._gravity)
    }
    
    func getLongitude(period: CGFloat) ->CGFloat{
        return pow((period/(2 * CGFloat.pi)), 2) * _gravity
    }
    
    func getGravity(period: CGFloat) -> CGFloat {
        return self._longitude / pow((period/(2 * CGFloat.pi)), 2)
    }
    
    func initPendulum(originX: CGFloat, originY: CGFloat, bobX: CGFloat, bobY: CGFloat) {
        self.originX = originX
        self.originY = originY
        self.bobX = bobX
        self.bobY = bobY
        self.angle = 0
        self.aAcc = 0
        self.aVel = 0
    }
    
    func movePendulum() {
        aVel += aAcc
        angle += aVel
        bobX = originX + pixels() * sin(angle)
        bobY = originY - pixels() * cos(angle)
        aAcc = (-1 * _gravity / Constants.DivideConstant / _longitude) * sin(angle)
    }
    
    func resetMovement() {
        aVel = 0
        aAcc = 0
    }
    
    func setUserConfig(longitude: CGFloat, gravity: CGFloat) {
        self._longitude = longitude
        self._gravity = gravity
    }
    
    func movePendulumWithTouch(location: CGPoint) -> Bool {
        let newBobX = location.x
        let deltaX = abs(newBobX - originX)
        let newBobY = originY - sqrt(pow(pixels(), 2) - pow(deltaX, 2))
        let newAngle = sinh(deltaX / pixels())
       
        if newAngle <= Constants.MaxAngle {
            bobX = newBobX
            bobY = newBobY
            angle = bobX < originX ? -newAngle : newAngle
            return true
        }
        
        return false
    }
    
    func getLineOrigin() -> CGPoint {
        return CGPoint(x: originX, y: originY)
    }
    func getBobPosition() -> CGPoint {
        return CGPoint(x: bobX, y: bobY)
    }
    
    func degrees() -> Int {
        let degrees = angle * 180 / CGFloat.pi
        return Int(round(degrees))
    }
    
    func pixels() -> CGFloat {
        return _longitude * Constants.RatioPixelsToMeters
    }
}
