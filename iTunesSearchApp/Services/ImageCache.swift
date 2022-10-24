//
//  ImageCache.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation
import UIKit

final class ImageCache {
    
    private init() {}
    
    static let shared = NSCache<NSString, UIImage>()
}
