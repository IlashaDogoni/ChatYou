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
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }

    func loadMessages() {
        messages = []
        db.collection(K.FStore.collectionName).getDocuments { QuerySnapshot, error in
            if let e = error{
                print("There was an issue etrieving data from Firestore \(e).")
            } else {
                if let snapshotDocuments = QuerySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody
            ]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e).")
                } else {
                    print("Successfully saved data.")
                }
            }
        }
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

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label .text = messages[indexPath.row].body
        return cell
    }
}

extension ChatViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
