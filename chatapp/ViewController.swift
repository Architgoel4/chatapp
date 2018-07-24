//
//  ViewController.swift
//  chatapp
//
//  Created by Goel, Archit on 18/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RemoteConfigManager.remoteConfigInit(firstControl: self.loginBtn )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginBtnClicked(_ sender: AnyObject) {
        FirebaseManager.Login(email: email.text!, password: password.text!) { (success: Bool) in
            if(success) {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    
    
    @IBAction func createAccountBtn_Clicked(_ sender: Any) {
        FirebaseManager.CreateUser(email: email.text!, password: password.text!, username: username.text!) { (result: String) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    
    
}

