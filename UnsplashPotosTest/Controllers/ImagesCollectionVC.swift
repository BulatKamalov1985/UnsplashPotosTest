//
//  ImagesCollectionVC.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 12.11.2021.
//

import Foundation
import UIKit

class ImagesCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    private var randomPhotos = [UnsplashPhoto]()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action,
                               target: self,
                               action: #selector(actionBarButtonTapped))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchBar()
        
        let loyaut = UICollectionViewFlowLayout()
        loyaut.scrollDirection = .vertical
        loyaut.itemSize = CGSize(width: (view.frame.size.width)-4,
                                 height: (view.frame.size.width)-4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifierCV)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard randomPhotos.isEmpty else { return }
        networkDataFetcher.fetchRandomImages(count: "30") { [weak  self] result in
            guard let results = result else { return }
            self?.randomPhotos = results
            self?.collectionView?.reloadData()
        }
    }
    
    //    MARK: NavigationItems action
    @objc private func actionBarButtonTapped() {
        print(#function)
    }
    
    //    MARK: Setup UI elements
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "IMAGES"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.rightBarButtonItems = [actionBarButtonItem]
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    //    MARK: UICollectionViewDataSource, UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.isEmpty {
            return randomPhotos.count
        }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifierCV, for: indexPath) as! ImageCollectionViewCell
        if photos.isEmpty {
            let unsplashPhoto = randomPhotos[indexPath.item]
            cell.unsplashPhoto = unsplashPhoto
        } else {
            let unsplashPhoto = photos[indexPath.item]
            cell.unsplashPhoto = unsplashPhoto
        }
        return cell
        
    }
    
    // Переход с CollectionVC на DetailVC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let unsplashPhoto = photos.isEmpty
        ? randomPhotos[indexPath.item]
        : photos [indexPath.item]
        
        let dvc = DetailVC(unsplashPhoto: unsplashPhoto)
        navigationController?.pushViewController(dvc, animated: true)
    }
}

//    MARK: UISearchBarDelegate
extension ImagesCollectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in
            networkDataFetcher.fetchImages(searchTerm: searchText) { [weak  self]searchResults in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                collectionView?.reloadData()
            }
        })
    }
}
