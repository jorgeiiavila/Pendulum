//
//  ViewController.swift
//  Pendulum
//
//  Created by Jorge Iribe on 13/10/19.
//  Copyright © 2019 Jorge Iribe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var simulatorBtn: UIButton!
    @IBOutlet weak var questionsBtn: UIButton!
    @IBOutlet weak var creditsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        
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
    
    func setUpUI(){
        self.simulatorBtn.layer.cornerRadius = 12
        self.questionsBtn.layer.cornerRadius = 12
        self.creditsBtn.layer.cornerRadius = 12
        
        let titleFont = UIFont.boldSystemFont(ofSize: 30)
        self.titleLbl.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: titleFont)
        self.titleLbl.adjustsFontForContentSizeCategory = true
        
        let buttonFont = UIFont.boldSystemFont(ofSize: 16)
        self.questionsBtn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        self.questionsBtn.titleLabel?.adjustsFontForContentSizeCategory = true
        
        self.simulatorBtn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        self.simulatorBtn.titleLabel?.adjustsFontForContentSizeCategory = true
        
        
        self.creditsBtn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: buttonFont)
        self.creditsBtn.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool { return false
    }
}

