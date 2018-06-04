//
//  ScannedQRResults.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/15/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import Foundation
import TwitterKit
import Contacts
import SwiftyUserDefaults


class ConnectAction {
    
    func followTwitterAccount(id: String) {
        
        let store = TWTRTwitter.sharedInstance().sessionStore
        let lastSession = store.session()
        
        
        // login follow by screenname
        let userID = lastSession?.userID
        
        let client = TWTRAPIClient(userID: userID)
        
        let statusesShowEndpoint = "https://api.twitter.com/1.1/friendships/create.json"
        let params = ["user_id": id, "follow": "true"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "POST", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    

    
    func createContact(workEmail: String = "", personalEmail: String = "", personalPhone: String = "", workPhone: String = "", firstName: String = "", lastName: String = "") {
        
        var store = CNContactStore()
        
        let newContact = CNMutableContact()
        newContact.givenName = firstName
        newContact.familyName = lastName
        

        // set the phone number
        let homePhone = CNLabeledValue(label: CNLabelHome,
                                       value: CNPhoneNumber(stringValue: personalPhone))
        let workPhone = CNLabeledValue(label: CNLabelWork,
                                       value: CNPhoneNumber(stringValue: workPhone))
        newContact.phoneNumbers = [homePhone, workPhone]
        
        // set the email addresse
        let homeEmail = CNLabeledValue(label: CNLabelHome,
                                       value: personalEmail as NSString)

        let workEmail = CNLabeledValue(label: CNLabelWork, value: workEmail as NSString)
        
        newContact.emailAddresses = [workEmail, homeEmail]
        
        let request = CNSaveRequest()
        request.add(newContact, toContainerWithIdentifier: nil)
        do{
            try store.execute(request)
            
            print("Successfully stored the contact")
        } catch let err{
            print("Failed to save the contact. \(err)")
        }
        
    }
    
}



