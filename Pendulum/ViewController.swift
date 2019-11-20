//
//  ViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var simulatorBtn: UIButton!
    @IBOutlet weak var questionsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simulatorBtn.layer.cornerRadius = 8
        questionsBtn.layer.cornerRadius = 8
    }

    @IBAction func questionsSection(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Questions", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ncQuestions")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func simulatorSection(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(identifier: "ncSimulator")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

