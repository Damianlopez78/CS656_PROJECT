//
//  ViewController.swift
//  CS656_NFCAPP
//
//  Created by Peter Bayiokos on 2/14/19.
//  Copyright © 2019 PeterB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create mesg variable
    var msg: String = ""

    @IBOutlet weak var txt_msg_view: UITextView!
    @IBOutlet weak var txt_msg_enter: UITextField!
    @IBAction func sndMsg(_ sender: Any) {
        //getting the input msg
        msg = txt_msg_enter.text!
        //displaying the msgs
        txt_msg_view.text = msg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

