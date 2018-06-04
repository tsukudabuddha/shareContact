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

class oldSettingsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker : UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var fullNameLabel: UITextField!
    @IBOutlet weak var workNumberLabel: UITextField!
    @IBOutlet weak var phoneNameLabel: UITextField!
    @IBOutlet weak var occupationLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var twitterChecker: UIImageView!
    @IBOutlet weak var linkedinChecker: UIImageView!
    
    @IBAction func twitterSigninButton(_ sender: UIButton) {
        // retreive saved session
        let store = TWTRTwitter.sharedInstance().sessionStore
        let lastSession = store.session()
        let sessions = store.existingUserSessions()
    
        if sessions.count > 0 {
            Defaults[.TwitterState] = true
            print("logged in already")
            self.twitterChecker.image = UIImage(named: "check_mark_on")
            self.twitterChecker.alpha = 1
        } else {
            // brings up login view
            TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                if (session != nil) {
                    print("signed in as \(session?.userName)")
                    guard let twitterID = lastSession?.userID else { return }
                    Defaults[.TwitterID] = twitterID
                    self.twitterChecker.image = UIImage(named: "check_mark_on")
                    self.twitterChecker.alpha = 1
                } else {
                    print("error: \(error?.localizedDescription)")
                }
            })
        }
            
        

        
    }
    
    
    @IBOutlet weak var profilePicture: UIButton!
    
    @IBAction func profileAdd(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true)
    }
    
    func roundPictureBoarder() {
        self.view.layoutIfNeeded()
        self.profilePicture.layer.borderWidth = 0
        self.profilePicture.layer.borderColor = UIColor.black.cgColor
        self.profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        self.profilePicture.layer.masksToBounds = true
        self.profilePicture.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        DispatchQueue.main.async {
            let imageUrl = info[UIImagePickerControllerImageURL] as! URL
            self.profilePicture.kf.setImage(with: imageUrl, for: .normal)
            Defaults[.ProfilePicture] = imageUrl
            
            self.roundPictureBoarder()
            
        }
        picker.dismiss(animated: true)
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        if Defaults[.ProfilePicture] == nil  {
            self.profilePicture.setImage(UIImage(named: "addPicture"), for: .normal)
            roundPictureBoarder()
        } else {
            // If an Image was already picked
            let imageString = Defaults[.ProfilePicture]
            profilePicture.kf.setImage(with: imageString, for: .normal)
            roundPictureBoarder()
        }
        
        let store = TWTRTwitter.sharedInstance().sessionStore
        let lastSession = store.session()
        let sessions = store.existingUserSessions()
        
        if sessions.count > 0 {
            // toggle state to on
            Defaults[.TwitterState] = true
            twitterChecker.image = UIImage(named: "check_mark_on")
        } else {
            twitterChecker.image = UIImage(named: "check_mark")
            twitterChecker.alpha = 0
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if !Defaults[.FullName].isEmpty {
            fullNameLabel.text = Defaults[.FullName]
        }
        
        if !Defaults[.WorkNumber].isEmpty {
            workNumberLabel.text = Defaults[.WorkNumber]
        }
        
        if !Defaults[.Occupation].isEmpty {
            occupationLabel.text = Defaults[.Occupation]
        }
        
        if !Defaults[.PersonalPhoneNumber].isEmpty {
            phoneNameLabel.text = Defaults[.PersonalPhoneNumber]
        }
        
        if !Defaults[.WorkEmail].isEmpty {
            emailLabel.text = Defaults[.WorkEmail]
        }
        
    }

    @IBAction func saveToDefaults(_ sender: UIButton) {
        Defaults[.FullName] = (fullNameLabel.text ?? "")
        Defaults[.PersonalPhoneNumber] = (phoneNameLabel.text ?? "")
        Defaults[.WorkNumber] = (workNumberLabel.text ?? "")
        Defaults[.Occupation] = (occupationLabel.text ?? "")
        Defaults[.WorkEmail] = (emailLabel.text ?? "")
        Defaults[.WorkNumber] = (workNumberLabel.text ?? "")
        
        let alert = UIAlertController(title: nil, message: "All Set!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    



}
