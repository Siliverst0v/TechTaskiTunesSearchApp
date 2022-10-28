//
//  AuthViewModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation

protocol AuthViewModelProtocol {
    func formatInputPhoneNumber(with mask: String, phone: String) -> String
}

final class AuthViewModel: AuthViewModelProtocol {
    
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
