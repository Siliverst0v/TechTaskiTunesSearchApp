//
//  AlbumsTableView.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 24.10.2022.
//

import Foundation
import UIKit

final class AlbumsTableView: UITableView {
    
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
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
        isScrollEnabled = true
        rowHeight = 100
        
        register(AlbumCellView.self, forCellReuseIdentifier: AlbumCellView.reuseIdentifier)
    }
}
