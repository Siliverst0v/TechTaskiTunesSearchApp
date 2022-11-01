//
//  RegViewModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

protocol RegViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func getCellViewModel(for indexPath: IndexPath) -> String
    func getFooter(for section: Int) -> String
    func nameIsValid(name: String) -> Bool
    func emailIsValid(email: String) -> Bool
    func passwordIsValid(password: String) -> Bool
    func formatInputPhoneNumber(with mask: String, phone: String) -> String
}

final class RegViewModel: RegViewModelProtocol {
    
    var profileInfo = [
        ["Name"],
        ["Surname"],
        ["Date of birth"],
        ["Phone number"],
        ["E-Mail"],
        ["Password"]
    ]
    
    func getNumberOfSections() -> Int {
        profileInfo.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        profileInfo[section].count
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> String {
        profileInfo[indexPath.section][0]
    }
    
    func getFooter(for section: Int) -> String {
        switch section {
        case 0,1:
            return "Only english letters"
        case 2:
            return "Аge not less than 18 years old"
        case 5:
            return "Password must be at least 6 characters long, must be a number, lower case letter, upper case letter"
        default:
            return ""
        }
    }
    
    func nameIsValid(name: String) -> Bool {
        let nameValidationRegex = "^[a-zA-Z]+$"
        let nameValidationPredicate = NSPredicate(format: "SELF MATCHES %@", nameValidationRegex)
        return nameValidationPredicate.evaluate(with: name)
    }
    
    func emailIsValid(email: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    func passwordIsValid(password: String) -> Bool {
        let passwordValidationRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,16}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        return passwordValidationPredicate.evaluate(with: password)
    }
    
    func formatInputPhoneNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
