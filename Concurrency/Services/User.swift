//
//  User.swift
//  Concurrency
//
//  Created by Aerolab on 27/03/2024.
//

import Foundation

struct UserObject {
    struct Phone {
        var code: UInt
        var number: UInt
    }
    
    var name: String
    var phone: Phone
}

@Observable class User {
    var instance: UserObject? = nil
    var isAuthorized = false
}
