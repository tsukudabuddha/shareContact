//
//  SocialOptionsController.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/14/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import TwitterKit
import AVFoundation
import QRCodeReader
import SwiftyUserDefaults
import Contacts
import SwiftInstagram
import Kingfisher


class SocialOptionsController: UIViewController, UITextFieldDelegate {


    // QR SCANNER
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // status bar white
        return .lightContent
    }
    
    // MARK: OUTLETS
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var workPhone: UIButton!
    @IBOutlet weak var workEmail: UIButton!
    @IBOutlet weak var personalEmail: UIButton!
    @IBOutlet weak var personalPhone: UIButton!
    
    @IBOutlet weak var twitterIcon: UIButton!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    @IBOutlet weak var QRButton: UIButton!
    
    // MARK: ACTIONS
    @IBAction func workEmailToggle(_ sender: UIButton) {
        
        if Defaults[.WorkEmailState] == false {
            workEmail.setImage(UIImage(named: "work-email-on"), for: .normal)
            workEmail.setNeedsDisplay()
            Defaults[.WorkEmailState] = true
            QRButtonState()
        }
        else {
            Defaults[.WorkEmailState] = false
            workEmail.setImage(UIImage(named: "work-email-off"), for: .normal)
            workEmail.setNeedsDisplay()
            QRButtonState()
 

        }
        
    }
    
    @IBAction func workPhoneToggle(_ sender: UIButton) {
        
        if Defaults[.WorkPhoneState] == false {
            workPhone.setImage(UIImage(named: "work-phone-on"), for: .normal)
            workPhone.setNeedsDisplay()
            Defaults[.WorkPhoneState] = true
            QRButtonState()
        }
        else {
            Defaults[.WorkPhoneState] = false
            workPhone.setImage(UIImage(named: "work-phone-off"), for: .normal)
            workPhone.setNeedsDisplay()
            QRButtonState()
        }
        
    }
    
    @IBAction func PersonalPhoneToggle(_ sender: UIButton) {
        
        if Defaults[.PersonalPhoneState] == false {
            personalPhone.setImage(UIImage(named: "personal-phone-on"), for: .normal)
            personalPhone.setNeedsDisplay()
            Defaults[.PersonalPhoneState] = true
            QRButtonState()
        }
        else {
            Defaults[.PersonalPhoneState] = false
            personalPhone.setImage(UIImage(named: "personal-phone-off"), for: .normal)
            personalPhone.setNeedsDisplay()
            QRButtonState()
            
        }
        
    }
    
    @IBAction func PersonalEmailToggle(_ sender: UIButton) {
        if Defaults[.PersonalEmailState] == false {
            personalEmail.setImage(UIImage(named: "personal-email-on"), for: .normal)
            personalEmail.setNeedsDisplay()
            Defaults[.PersonalEmailState] = true
            QRButtonState()
        }
        else {
            Defaults[.PersonalEmailState] = false
            personalEmail.setImage(UIImage(named: "personal-email-off"), for: .normal)
            personalEmail.setNeedsDisplay()
            QRButtonState()
            
        }
    }
    
    
    @IBAction func twitterfacebookToggle(_ sender: UIButton) {
        
        if Defaults[.TwitterState] == false {
            twitterIcon.setImage(UIImage(named: "twitter-on"), for: .normal)
            twitterIcon.setNeedsDisplay()
            Defaults[.TwitterState] = true
            QRButtonState()
        }
        else {
            Defaults[.TwitterState] = false
            twitterIcon.setImage(UIImage(named: "twitter-off"), for: .normal)
            twitterIcon.setNeedsDisplay()
            QRButtonState()
        }
        
    }
    
    func QRButtonState() {
        if Defaults[.WorkPhoneState] || Defaults[.WorkEmailState] || Defaults[.PersonalEmailState] || Defaults[.PersonalPhoneState] || Defaults[.TwitterState] == true {
            QRButton.isHidden = false
            QRButton.pulsate()
            QRButton.reloadInputViews()
        } else {
            QRButton.isHidden = true
            QRButton.reloadInputViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        addNavBarImage()
        
        if Defaults[.TwitterState] == true {
            twitterIcon.imageView?.image = UIImage(named: "twitter-on")
        }
        
        if Defaults[.WorkPhoneState] == true {
            workPhone.imageView?.image = UIImage(named: "work-phone-on")
        }
        
        if Defaults[.WorkEmailState] == true {
            workEmail.imageView?.image = UIImage(named: "work-email-on")
        }
        
        if Defaults[.PersonalPhoneState] == true {
            personalPhone.imageView?.image = UIImage(named: "personal-phone-on")
        }
        
        if Defaults[.PersonalEmailState] == true {
            personalEmail.imageView?.image = UIImage(named: "personal-email-on")
        }
        
        
        QRButtonState()
   
    }
    
    func roundPictureBoarder() {
        self.view.layoutIfNeeded()
        profilePicture.layer.borderWidth = 0
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicture.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Defaults[.ProfilePicture] == nil  {
            profilePicture.image = UIImage(named: "1")
            roundPictureBoarder()
        } else {
            // If an Image was already picked
            let imageString = Defaults[.ProfilePicture]
            profilePicture.kf.setImage(with: imageString, placeholder: nil)
            roundPictureBoarder()
            
        }
        
        if !Defaults[.FullName].isEmpty {
            nameLabel.text = "\(Defaults[.FullName])"
        } else {
            nameLabel.text = "Input Name"
        }
        
        if !Defaults[.Occupation].isEmpty {
            occupationLabel.text = Defaults[.Occupation]
        } else {
            occupationLabel.text = "Description"
        }
        
        
        
    }
    
    
    // NAV BAR
    func addNavBarImage() {
        
        let image = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: image)
        
        guard let bannerWidth = navigationController?.navigationBar.frame.size.width else { return }
        guard let bannerHeight = navigationController?.navigationBar.frame.size.height else { return }
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: 2 , height: 2)
        imageView.contentMode = .scaleAspectFit
        
        
        navigationItem.titleView = imageView
        // REMOVE BOTTOM BORDER
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 72/255, green: 170/255, blue: 230/255, alpha: 1)
        
    }
   
}

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        pulse.mass = 10.0
        pulse.repeatCount = Float.infinity
        
        layer.add(pulse, forKey: "pulse")
    }
}


