//
//  AuthSaveButtonCell.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 30.10.2022.
//

import Foundation
import UIKit

final class AuthSaveButtonCell: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.isHidden = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            saveButton.topAnchor.constraint(equalTo: topAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure(with viewModel: AuthViewModelProtocol, for indexPath: IndexPath) {
        let cellInfo = viewModel.getCellViewModel(for: indexPath)
        saveButton.setTitle(cellInfo, for: .normal)
    }
}
