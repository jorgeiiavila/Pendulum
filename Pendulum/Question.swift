//
//  Question.swift
//  Pendulum
//
//  Created by Francisco Castro on 10/14/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class Question: NSObject {
    var question: String
    var answers: [Answer]
    
    
    init(question: String, answers: [Answer]) {
        self.question = question
        self.answers = answers
    }
}
