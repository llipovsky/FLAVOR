//
//  LoginSignUpViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {

    // UI View Properties
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var dontHaveAccountLabel: CustomLabel!
    @IBOutlet weak var signUpButton: CustomButton!
    @IBOutlet weak var titleLabel: CustomLabel!
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpProperties()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set up the UI Elements
    func setUpProperties() {
        
        //(signUpButton as! CustomButton).makeCustomWhiteButton()
        signUpButton.makeCustomWhiteButton()
        titleLabel.setSpacing(labelSpace: 2.25)
       
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
