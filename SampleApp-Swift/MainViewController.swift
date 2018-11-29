//
//  MainViewController.swift
//  SampleApp-Swift
//
//  Created by Nir Lachman on 12/02/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit
import LPMessagingSDK
import LPAMS
import LPInfra

class MainViewController: UIViewController {
    let accountNumber = ""
    var conversationQuery: ConversationParamProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.messagingHandlerDelegate = MessagingHandlerDelegate();
//        LPMessagingSDK.instance.delegate = self.messagingHandlerDelegate
        
        conversationQuery = LPMessagingSDK.instance.getConversationBrandQuery(accountNumber)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // MARK: IBActions
    @IBAction func messagingClicked(_ sender: Any) {
       self.performSegue(withIdentifier: "showMessaging", sender: self)
    }
    
    @IBAction func monitoringClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "showMonitoring", sender: self)
    }
    
    @IBAction func getUnreadMessagesClicked(_ sender: Any) {
        LPMessagingSDK.getUnreadMessagesCount(self.conversationQuery!, completion: { (num: Int) in
            //
            print("@@@ unreadMessagesCount \(num)")
            
            let alert = UIAlertController(title: "Unread Messages", message: "You have \(num) unread message(s)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert,animated: true,completion: nil)
            
            
//            self.showToast(message: "You have \(num) unread message(s)")
        }) { (NSError) in
            //
            print("@@@ ERROR unreadMessagesCount ");
            //            self.showToast(message: "ERROR unreadMessagesCount \(NSError.domain) \(String(describing: NSError.localizedFailureReason))")
            
            let alert = UIAlertController(title: "Unread Messages", message: "ERROR unreadMessagesCount \(NSError.domain) \(String(describing: NSError.localizedFailureReason))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"ERROR\" alert occured.")
            }))
            self.present(alert,animated: true,completion: nil)
        }
    }
}
