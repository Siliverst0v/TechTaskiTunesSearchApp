//
//  AlbumDetailsViewModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation
import UIKit

protocol AlbumDetailsViewModelProtocol {
    var tracks: [Track] {get set}
    var albumLogo: UIImage {get set}
    func setupAlbumInfo() -> Album 
    func fetchTracks(completion: @escaping (Album) -> Void)
    func formatMillisecsToMinutes(milliseconds: Int?) -> String
}

final class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {
    
    var album: Album
    var albumLogo: UIImage
    var tracks: [Track] = []
    
    
    init(album: Album, albumLogo: UIImage) {
        self.album = album
        self.albumLogo = albumLogo
    }
    
    func setupAlbumInfo() -> Album {
        self.album
    }
    
    func formatMillisecsToMinutes(milliseconds: Int?) -> String {
        if let milliseconds = milliseconds {
            let interval:Double = Double(milliseconds)/1000
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            let formattedString = formatter.string(from: TimeInterval(interval.rounded()))!
            return formattedString
        }
        return "0:00"
    }
    
    func fetchTracks(completion: @escaping (Album) -> Void) {
        DispatchQueue.global(qos: .background).async {
            NetworkManager.shared.fetchTracks(collectionID: self.album.collectionId) { tracks in
                self.tracks = tracks
                completion(self.album)
            }
        }
    }
}
