//
//  ViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func preguntas(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Questions", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ncQuestions")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

