//
//  AlbumsViewModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 24.10.2022.
//

import Foundation

protocol AlbumsViewModelProtocol {
    var albums: [Album] {get set}
    func getAlbums(searchText: String, completion: @escaping () -> Void)
}

final class AlbumsViewModel: AlbumsViewModelProtocol {
    
    var albums = [Album]()
    
    func getAlbums(searchText: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchAlbums(searchText: searchText) { albums in
            self.albums = albums.results.sorted(by: {$0.collectionName < $1.collectionName})
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
