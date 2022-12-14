//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 23.10.2022.
//

import UIKit

final class AlbumsViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let albumTableView = AlbumsTableView()
    private let viewModel: AlbumsViewModelProtocol
    
    init(viewModel: AlbumsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Название альбома"
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupLayout()
    }
    
    private func setDelegates() {
        searchBar.delegate = self
        albumTableView.delegate = self
        albumTableView.dataSource = self
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(albumTableView)
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            albumTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            albumTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCellView.reuseIdentifier, for: indexPath) as? AlbumCellView
        cell?.configure(with: viewModel, for: indexPath)
        return cell ?? AlbumCellView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? AlbumCellView, let albumLogo = cell.albumLogo.image {
            self.navigationController?.pushViewController(AlbumDetailsConfigurator.configure(with: album, albumLogo: albumLogo), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else {return}
        viewModel.getAlbums(searchText: text) {
            self.albumTableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
}

