//
//  AlbumCellView.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 24.10.2022.
//

import Foundation
import UIKit

final class AlbumCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let albumLogo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "camera")
        view.tintColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.minimumScaleFactor = 8
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.minimumScaleFactor = 8
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(albumLogo)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(trackCountLabel)
        
        NSLayoutConstraint.activate([
            
            albumLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumLogo.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            albumLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            albumLogo.widthAnchor.constraint(equalTo: heightAnchor),
            
            albumNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            albumNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4),
            
            trackCountLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 16),
            trackCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trackCountLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8)
            
        ])
    }
    
    func configure(with viewModel: AlbumsViewModelProtocol, for indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "Количество трэков - \(album.trackCount)"
        
        NetworkManager.shared.loadImage(url: URL(string: album.artworkUrl100)) { image in
            DispatchQueue.main.async {
                self.albumLogo.image = image
            }
        }
    }
}
