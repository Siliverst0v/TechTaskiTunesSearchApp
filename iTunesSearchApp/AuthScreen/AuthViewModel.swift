//
//  AuthViewModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

protocol AuthViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func getCellViewModel(for indexPath: IndexPath) -> String
    func emailIsValid(email: String) -> Bool
    func passwordIsValid(password: String) -> Bool
    func alert(vc: UIViewController, title: String, message: String)
    func formatInputPhoneNumber(with mask: String, phone: String) -> String
}

final class AuthViewModel: AuthViewModelProtocol {
    
    var profileInfo = [
        ["Name"],
        ["Second Name"],
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
    
    func alert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
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
