//
//  ImagesTableVC.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 12.11.2021.
//

import Foundation
import UIKit

class ImagesTableVC: UIViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    
    private var randomPhotos = [UnsplashPhoto]()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idImageTableVC = "idImageTableVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: idImageTableVC)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 105
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard randomPhotos.isEmpty else { return }
        networkDataFetcher.fetchRandomImages(count: "30") { [weak  self] result in
            guard let results = result else { return }
            self?.randomPhotos = results
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "FAVORITES"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .systemGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
}

// MARK: UiTableViewDelegate, UiTableViewDataSource

extension ImagesTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idImageTableVC, for: indexPath) as! ImageTableViewCell
        print("indexPath")
        cell.imageTitleLabel.text = randomPhotos[indexPath.row].user.name
        cell.unsplashPhoto = randomPhotos[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = DetailVC(unsplashPhoto: randomPhotos[indexPath.row])
        navigationController?.pushViewController(dvc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ImagesTableVC {
    
    func setConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
