//
//  LoginViewController.swift
//  Hosee
//
//  Created by Duc Anh on 4/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if userText.text == "+84924586555" && passwordText.text == "123456" {
            DataServices.sharedInstance.makeDataTaskRequest(user: userText.text!, pass: passwordText.text!) { (data) in
                print(data.data)
            }
        }
       
    }
    
    

}
