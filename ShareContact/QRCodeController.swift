//
//  QRCodeController.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/14/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import TwitterKit
import QRCode
import SwiftyUserDefaults

class QRCodeController: UIViewController {
    
    
    @IBOutlet weak var QRCodeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupQRCode()
        
    }
    
    func setupQRCode() {
        
        var urlString = "https://share-contact.herokuapp.com/webform?"
        
        if Defaults[.TwitterState] == true {
            
            let store = TWTRTwitter.sharedInstance().sessionStore
            let lastSession = store.session()
            if let userID = lastSession?.userID {
                urlString.append("Twitter=\(userID)&")
            }

        }
        
        if Defaults[.PersonalPhoneState] == true {
            
            let phoneNumber = Defaults[.PersonalPhoneNumber]
            urlString.append("PersonalPhone=\(phoneNumber)&")
        }
        
        if Defaults[.PersonalEmailState] == true {
            let personalEmail = Defaults[.PersonalEmail]
            urlString.append("PersonalEmail=\(personalEmail)&")
        }
        
        if Defaults[.WorkEmailState] == true {
            
            let email = Defaults[.WorkEmail]
            urlString.append("WorkEmail=\(email)&")
        }
        
        if Defaults[.WorkPhoneState] == true {
            let workPhoneNumber = Defaults[.WorkNumber]
            urlString.append("WorkPhone=\(workPhoneNumber)&")
        }
        
        if !Defaults[.FullName].isEmpty {
            let fullName = Defaults[.FullName]
            
            if fullName.contains(" ") == false {
                if let firstName = fullName.components(separatedBy: " ").first {
                    urlString.append("FirstName=\(firstName)&")
                    let lastName = ""
                    urlString.append("LastName=\(lastName)&")
                }
                
            } else {
                
                if let firstName = fullName.components(separatedBy: " ").first {
                    urlString.append("FirstName=\(firstName)&")
                }
                
                if let lastName = fullName.components(separatedBy: " ").last {
                    urlString.append("LastName=\(lastName)&")
                }
            }
            
        }
        
    
        
        // URL
        let url = URL(string: urlString)!
        let qrCode = QRCode(url)
        
        QRCodeImageView.image = qrCode?.image
    }

   

}
