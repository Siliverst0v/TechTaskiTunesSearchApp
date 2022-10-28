//
//  TrackModel.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation

struct AlbumTracks: Codable {
    let results: [Track]
}

struct Track: Codable {
    let wrapperType: String
    var trackName: String?
    var trackNumber: Int?
    let trackTimeMillis: Int?
}
