//
//  AuthConfigurator.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class RegConfigurator {
    
    static func configure() -> UIViewController {
        let viewModel: RegViewModelProtocol = RegViewModel()
        let authVC = RegViewController(viewModel: viewModel)
        return authVC
    }
}
