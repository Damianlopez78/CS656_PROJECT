//
//  ViewController.swift
//  NJITNFCApp
//
//  Created by Peter Bayiokos on 3/28/19.
//  Copyright © 2019 PeterB. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {

    var nfcSession: NFCNDEFReaderSession?
    
    @IBAction func startNFCScan(_ sender: Any) {
      
        
        guard nfcSession == nil else {
            return
        }
        
        nfcSession = NFCNDEFReaderSession(delegate: self as NFCNDEFReaderSessionDelegate, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "NJIT NFC Scanner \n\n Please hold top of device near NFC tag"
        nfcSession?.begin()
    }
    
   @IBOutlet weak var nfcStartButton : UIButton!

    override func viewDidLoad() {
       super.viewDidLoad()
        nfcStartButton.layer.cornerRadius = 5
        nfcStartButton.layer.borderWidth = 1
        nfcStartButton.layer.borderColor = UIColor.clear.cgColor

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nfcSession = nil
    }
}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
        //Below comes from Apple CoreNFC Documentation used to initiate NFC Reading
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {

               let nfcMessages = messages.description
                print(nfcMessages)
            //Customizable alert to show successful scan
            let alertController = UIAlertController(title: "Successfully Scanned!", message:
                nfcMessages, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alertController, animated: true, completion: nil)
      
            self.nfcSession = nil
        }
        
        
        //Below comes from Apple CoreNFC Documenation used to handle errors
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
            if let readerError = error as? NFCReaderError {
     
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    let alertController = UIAlertController(
                        title: "Session Invalidated",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    DispatchQueue.main.async {
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
            // A new session instance is required to read new tags.
            self.nfcSession = nil
        }


}

