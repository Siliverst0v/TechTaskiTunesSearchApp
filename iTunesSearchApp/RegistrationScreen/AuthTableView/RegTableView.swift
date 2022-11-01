//
//  AuthTableView.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class RegTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        contentInset = .zero
        allowsSelection = true
        allowsMultipleSelection = false
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
        separatorStyle = .none
        rowHeight = 55
        
        register(ProfileInfoCell.self, forCellReuseIdentifier: ProfileInfoCell.reuseIdentifier)
        register(FooterView.self, forHeaderFooterViewReuseIdentifier: FooterView.reuseIdentifier)
    }
}
