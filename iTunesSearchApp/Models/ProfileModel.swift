//
//  Profile.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 30.10.2022.
//

import Foundation

struct Profile: Codable {
    var name: String
    var secondName: String
    var dateOfBirth: String
    var phoneNumber: String
    var email: String
    var password: String
    
    init(name: String, secondName: String,dateOfBirth: String, phoneNumber: String, email: String, password: String) {
        self.name = name
        self.secondName = secondName
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
    }
}
