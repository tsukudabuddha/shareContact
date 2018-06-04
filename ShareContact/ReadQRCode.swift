//
//  SocialOptions+Extension.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/15/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import AVFoundation
import QRCodeReader
import Foundation

extension SocialOptionsController: QRCodeReaderViewControllerDelegate {
    

    @IBAction func scanAction(_ sender: AnyObject) {
        // Retrieve the QRCode content
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            
            let connect = ConnectAction()
            
            // Parse Twitter ID from url
            if let twitterID = result?.value.slice(from: "Twitter=", to: "&") {
                connect.followTwitterAccount(id: twitterID)

            }
            
            guard let personalNumberResult = result?.value.slice(from: "PersonalPhone=", to: "&") else { return }
            
            guard let personalEmailResult = result?.value.slice(from: "PersonalEmail=", to: "&") else { return }
            
            guard let workEmailResult = result?.value.slice(from: "WorkEmail=", to: "&") else { return }
            
            guard let workNumberResult = result?.value.slice(from: "WorkPhone=", to: "&") else { return }
            
            guard let firstNameResult = result?.value.slice(from: "FirstName=", to: "&") else { return }
            
            guard let lastNameResult = result?.value.slice(from: "LastName=", to: "&") else { return }
            
            
            connect.createContact(workEmail: workEmailResult, personalEmail: personalEmailResult, personalPhone: personalNumberResult, workPhone: workNumberResult, firstName: firstNameResult, lastName: lastNameResult)
            
    }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
        
    }

    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
