//
//  Pendulum.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class Pendulum: NSObject {
    let mass = 1
    var longitude: Float
    var gravity: Float
    
    override init() {
        longitude = 0.7
        gravity = 9.8
    }
    
    init(longitude: Float, gravity: Float) {
        self.longitude = longitude
        self.gravity = gravity
    }
    
    func getPeriod() -> Float {
        return 2 * 3.14159265359 * sqrt(self.longitude/self.gravity)
    }
    
    func getLongitude(period: Float) ->Float{
        return pow((period/(2 * 3.14159265359)), 2) * gravity
    }
    
    func getGravity(period: Float) -> Float {
        return self.longitude / pow((period/(2 * 3.14159265359)), 2)
    }
    
}
