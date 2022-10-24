//
//  NetworkManager.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 23.10.2022.
//

import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let searchAlbumURL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
    let albumSongsURL = "https://itunes.apple.com/lookup?entity=song&id="
    
    func fetchAlbums(searchText: String, completion: @escaping (Welcome) -> Void) {
        
        let searchString = searchText.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "\(searchAlbumURL)\(searchString)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let albums = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    completion(albums)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func loadImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }

        if let cachedImage = imageFrom(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
              error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            completion(image)
            self.saveImageToCache(image: image, url: url, cost: responseData.count)
        }.resume()
    }
    
    private func imageFrom(url: URL) -> UIImage? {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        return nil
    }
    
    private func saveImageToCache(image: UIImage,url: URL, cost: Int) {
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString, cost: cost)
    }
}
