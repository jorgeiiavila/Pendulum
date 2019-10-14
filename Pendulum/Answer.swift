//
//  Answer.swift
//  Pendulum
//
//  Created by Francisco Castro on 10/14/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class Answer: NSObject {
    var answer: String
    var isCorrect: Bool
    
    init(answer: String, isCorrect: Bool) {
        self.answer = answer
        self.isCorrect = isCorrect
    }

}
