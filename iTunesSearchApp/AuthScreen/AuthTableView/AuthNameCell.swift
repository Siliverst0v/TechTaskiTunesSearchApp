//
//  AuthNameCell.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class AuthNameCell: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 17)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftViewMode = .always
        return textField
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
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure(with viewModel: AuthViewModelProtocol, for indexPath: IndexPath) {
        let placeholder = viewModel.getCellViewModel(for: indexPath)
        self.textField.placeholder = placeholder
    }
}
