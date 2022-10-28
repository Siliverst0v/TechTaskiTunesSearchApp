//
//  AlbumModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 23.10.2022.
//

import Foundation

struct Albums: Codable {
    let results: [Album]
}

struct Album: Codable {
    
    let artistName: String
    var artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let trackCount: Int
    let releaseDate: String
}

