//
//  AlbumDetailsConfigurator.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation
import UIKit

final class AlbumDetailsConfigurator {
    
    static func configure(with album: Album, albumLogo: UIImage) -> UIViewController {
        let viewModel = AlbumDetailsViewModel(album: album, albumLogo: albumLogo)
        let albumDetailsVC = AlbumDetailsViewController(viewModel: viewModel)
        return albumDetailsVC
    }
}
