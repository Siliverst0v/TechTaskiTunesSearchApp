//
//  AlbumsConfigurator.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 24.10.2022.
//

import Foundation
import UIKit

final class AlbumsConfigurator {
    static func configure() -> UIViewController {
        let viewModel = AlbumsViewModel()
        let albumsVC = AlbumsViewController(viewModel: viewModel)
        return albumsVC
    }
}
