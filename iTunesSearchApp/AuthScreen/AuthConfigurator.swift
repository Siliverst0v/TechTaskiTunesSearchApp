//
//  AuthConfigurator.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class AuthConfigurator {
    
    static func configure() -> UIViewController {
        let viewModel: AuthViewModelProtocol = AuthViewModel()
        let authVC = AuthViewController(viewModel: viewModel)
        return authVC
    }
}
