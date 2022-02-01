//
//  LoginViewController.swift
//  ChatYou
//
//  Created by Ilya Kokorin on 23.01.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if  let e = error {
                self.errorLabel.text = (e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "LoginToChat", sender: self)
            }
          // ...
        }
        }
    }
    
}
