//
//  ViewController.swift
//  ChatYou
//
//  Created by Ilya Kokorin on 23.01.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var titlelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleText = K.appName
        var charIndex = 0.0
        titlelabel.text = ""
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false, block: { (timer) in
                self.titlelabel.text?.append(letter)
            })
            charIndex += 1
        }
    }
}

