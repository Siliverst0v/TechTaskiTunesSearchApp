//
//  Model.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 23.10.2022.
//

import Foundation

struct Welcome: Codable {
    let results: [Result]
}

struct Result: Codable {
    
    let artistName: String
    var artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let trackCount: Int
    let releaseDate: String
    
    init(artistName: String, artworkUrl100: String, collectionId: Int, collectionName: String, trackCount: Int, releaseDate: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.trackCount = trackCount
        self.releaseDate = releaseDate
    }
}

struct Track: Codable {
    
    var trackName: String
    var trackNumber: Int
    
    init(trackName: String, trackNumber: Int) {
        self.trackName = trackName
        self.trackNumber = trackNumber
    }
}
