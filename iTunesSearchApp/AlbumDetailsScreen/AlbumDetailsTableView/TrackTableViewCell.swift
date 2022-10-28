//
//  TrackTableViewCell.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 25.10.2022.
//

import Foundation
import UIKit

final class TrackTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let trackNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let trackTimeLabel: UILabel = {
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
        addSubview(trackNumberLabel)
        addSubview(trackNameLabel)
        addSubview(trackTimeLabel)
        
        NSLayoutConstraint.activate([
        
            trackNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            trackNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackNumberLabel.trailingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor, constant: -16),
            trackNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor),
            trackNameLabel.leadingAnchor.constraint(equalTo: trackNumberLabel.trailingAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            trackNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            trackTimeLabel.topAnchor.constraint(equalTo: topAnchor),
            trackTimeLabel.leadingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor, constant: 16),
            trackTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trackTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure(with viewModel: AlbumDetailsViewModelProtocol,for indexPath: IndexPath) {
        let track = viewModel.tracks[indexPath.row]
        guard let number = track.trackNumber else {return}
        let time = viewModel.formatMillisecsToMinutes(milliseconds: track.trackTimeMillis)
        trackNumberLabel.text = "\(number)"
        trackNameLabel.text = track.trackName
        trackTimeLabel.text = "\(time)"
    }
}
