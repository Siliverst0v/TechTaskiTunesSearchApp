//
//  HeaderView.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 01.11.2022.
//

import Foundation
import UIKit

final class FooterView: UITableViewHeaderFooterView {
    static var reuseIdentifier: String { "\(Self.self)" }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        contentView.backgroundColor = .white

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
        ])
    }
    
    func configure(with viewModel: RegViewModelProtocol, for section: Int) {
        let title = viewModel.getFooter(for: section)
        titleLabel.text = title
    }
}
