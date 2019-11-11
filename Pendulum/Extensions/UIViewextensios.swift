//
//  UIViewextensios.swift
//  Pendulum
//
//  Created by Fernando Salazar on 04/11/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

extension UIView {

    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
    func setAnchorPoint(_ point: CGPoint) {
           var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
           var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

           newPoint = newPoint.applying(transform)
           oldPoint = oldPoint.applying(transform)

           var position = layer.position

           position.x -= oldPoint.x
           position.x += newPoint.x

           position.y -= oldPoint.y
           position.y += newPoint.y

           layer.position = position
           layer.anchorPoint = point
       }

}
