//
//  SettingsViewController.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/21/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Kingfisher
import TwitterKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var personalEmailTextField: UITextField!
    @IBOutlet weak var workEmailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var workNumberTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    
    
    
    @IBAction func twitterSigninButton(_ sender: UIButton) {
        // retreive saved session
        let store = TWTRTwitter.sharedInstance().sessionStore
        let lastSession = store.session()
        let sessions = store.existingUserSessions()
        
        if sessions.count > 0 {
            Defaults[.TwitterState] = true
            print("logged in already")
            
        } else {
            // brings up login view
            TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                if (session != nil) {
                    print("signed in as \(session?.userName)")
                    guard let twitterID = lastSession?.userID else { return }
                    Defaults[.TwitterID] = twitterID
//                     = UIImage(named: "check_mark_on")
//                    self.twitterChecker.alpha = 1
                } else {
                    print("error: \(error?.localizedDescription)")
                }
            })
        }
        
        
        
        
    }
    
    @IBOutlet weak var userProfilePicture: UIButton!
    
   // @IBOutlet weak var profilePicture: UIButton!
    
    @IBAction func profileAdd(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true)
    }
    
    func roundPictureBoarder() {
        self.view.layoutIfNeeded()
        self.userProfilePicture.layer.borderWidth = 0
        self.userProfilePicture.layer.borderColor = UIColor.black.cgColor
        self.userProfilePicture.layer.cornerRadius = userProfilePicture.frame.size.width / 2
        self.userProfilePicture.layer.masksToBounds = true
        self.userProfilePicture.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        DispatchQueue.main.async {
            let imageUrl = info[UIImagePickerControllerImageURL] as! URL
            self.userProfilePicture.kf.setImage(with: imageUrl, for: .normal)
            Defaults[.ProfilePicture] = imageUrl
            
            self.roundPictureBoarder()
            
        }
        picker.dismiss(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Defaults[.ProfilePicture] == nil  {
            self.userProfilePicture.setImage(UIImage(named: "addPicture"), for: .normal)
            roundPictureBoarder()
        } else {
            // If an Image was already picked
            let imageString = Defaults[.ProfilePicture]
            userProfilePicture.kf.setImage(with: imageString, for: .normal)
            roundPictureBoarder()
        }
        
        let store = TWTRTwitter.sharedInstance().sessionStore
        let lastSession = store.session()
        let sessions = store.existingUserSessions()
        
        if sessions.count > 0 {
            // toggle state to on
            Defaults[.TwitterState] = true
            /*  = UIImage(named: "check_mark_on")*/
        } // else {
//            twitterChecker.image = UIImage(named: "check_mark")
//            twitterChecker.alpha = 0
//        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserDefaults()
        
    }
    
    
    private func checkUserDefaults() {
        
    
        if !Defaults[.FullName].isEmpty {
            fullnameTextField.text = Defaults[.FullName]
        }
        
        if !Defaults[.PersonalEmail].isEmpty {
            personalEmailTextField.text = Defaults[.PersonalEmail]
        }
        
        if !Defaults[.WorkEmail].isEmpty {
            workEmailTextField.text = Defaults[.WorkEmail]
        }
        
        if !Defaults[.PersonalPhoneNumber].isEmpty {
            mobileNumberTextField.text = Defaults[.PersonalPhoneNumber]
        }
        
        if !Defaults[.WorkNumber].isEmpty {
            workNumberTextField.text = Defaults[.WorkNumber]
        }
        
        if !Defaults[.Occupation].isEmpty {
            occupationTextField.text = Defaults[.Occupation]
        }
        
//        if !Defaults[.PhoneNumber].isEmpty {
//            phoneNameLabel.text = Defaults[.PhoneNumber]
//        }
//
//        if !Defaults[.Email].isEmpty {
//            emailLabel.text = Defaults[.Email]
//        }
    }
    
    @IBAction func saveToDefaults(_ sender: UIButton) {
        Defaults[.FullName] = fullnameTextField.text ?? ""
        Defaults[.PersonalEmail] = personalEmailTextField.text ?? ""
        Defaults[.WorkEmail] = workEmailTextField.text ?? ""
        Defaults[.PersonalPhoneNumber] = mobileNumberTextField.text ?? ""
        Defaults[.WorkNumber] = workNumberTextField.text ?? ""
        Defaults[.Occupation] = occupationTextField.text ?? ""
//        Defaults[.Email] = (personalEmailTextField.text ?? "")
//        Defaults[.WorkNumber] = (workNumberLabel.text ?? "")
        
        let alert = UIAlertController(title: nil, message: "All Set!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    
    
    
}
