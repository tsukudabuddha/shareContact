//
//  UserDefaults+Extension.swift
//  ShareContact
//
//  Created by Johnathan Chen on 3/15/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let TwitterState = DefaultsKey<Bool>("TwitterState")
    
    // Phone State
    static let WorkPhoneState = DefaultsKey<Bool>("WorkPhoneState")
    static let PersonalPhoneState = DefaultsKey<Bool>("PersonalPhoneState")
    
    // Email State
    static let PersonalEmailState = DefaultsKey<Bool>("PersonalEmailState")
    static let WorkEmailState = DefaultsKey<Bool>("EmailState")
    
    static let ProfilePicture = DefaultsKey<URL?>("ProfilePicture")
    static let FullName = DefaultsKey<String>("FullName")
    
    static let MobileNumber = DefaultsKey<String>("MobileNumber")
    static let WorkNumber = DefaultsKey<String>("WorkNumber")
    static let Occupation = DefaultsKey<String>("Occupation")
    
    // Phone Data
    static let PersonalPhoneNumber = DefaultsKey<String>("PersonalPhoneNumber")
    static let WorkPhoneNumber = DefaultsKey<String>("WorkPhoneNumber")
    
    // Email Data
    static let PersonalEmail = DefaultsKey<String>("PersonalEmail")
    static let WorkEmail = DefaultsKey<String>("WorkEmail")
    
    static let TwitterID = DefaultsKey<String>("TwitterID")
    
    
}
