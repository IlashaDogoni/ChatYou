//
//  ChatViewController.swift
//  ChatYou
//
//  Created by Ilya Kokorin on 23.01.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat🍆You"
        navigationItem.hidesBackButton = true
        
    }


    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
}
