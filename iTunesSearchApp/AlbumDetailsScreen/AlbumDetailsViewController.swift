//
//  AlbumDetailsViewController.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation
import UIKit

final class AlbumDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tracksTableView = AlbumDetailsTableView()
    private let viewModel: AlbumDetailsViewModelProtocol
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.minimumScaleFactor = 8
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .red
        label.minimumScaleFactor = 8
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    init(viewModel: AlbumDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDelegates()
        setupLayout()
        fetchTrackList()
    }
    
    private func setDelegates() {
        tracksTableView.delegate = self
        tracksTableView.dataSource = self
    }
    
    private func fetchTrackList() {
        viewModel.fetchTracks { album in
            DispatchQueue.main.async {
                let newFormatter = ISO8601DateFormatter()
                let df = DateFormatter()
                df.dateFormat = "yyyy"
                guard let isodate = newFormatter.date(from: album.releaseDate) else {return}
                let date = df.string(from: isodate)
                self.logoImageView.image = self.viewModel.albumLogo
                self.albumNameLabel.text = album.collectionName
                self.artistNameLabel.text = album.artistName
                self.releaseDateLabel.text = date
                self.tracksTableView.reloadData()
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(tracksTableView)
        view.addSubview(albumNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            albumNameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 8),
            albumNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            albumNameLabel.bottomAnchor.constraint(equalTo: artistNameLabel.topAnchor, constant: -4),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            artistNameLabel.bottomAnchor.constraint(equalTo: releaseDateLabel.topAnchor, constant: -8),
            
            releaseDateLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            releaseDateLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -8),
            
            tracksTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            tracksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tracksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tracksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier, for: indexPath) as? TrackTableViewCell
        cell?.configure(with: viewModel, for: indexPath)
        cell?.layer.cornerRadius = 5
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = .lightGray.withAlphaComponent(0.1)
        }
        return cell ?? TrackTableViewCell()
    }
}
