//
//  Constants.swift
//  Pendulum
//
//  Created by Jorge Iribe on 17/11/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

struct Constants {
    static let EarthGravity: CGFloat = 9.81
    static let DivideConstant: CGFloat = 2300
    static let RatioPixelsToMeters: CGFloat = 320 // 320 pixels equals 1 meter
    static let DefaultGravity: CGFloat = 9.81
    static let DefaultLongitude: CGFloat = 0.7
    static let DefaultCircleRadius: CGFloat = 40
    static let MaxAngle = CGFloat.pi / 6
    static let Damping: CGFloat = 0.995
    static let MaxLongitudeValue: CGFloat = 1.0
    static let MaxGravityValue: CGFloat = 20.0
}
