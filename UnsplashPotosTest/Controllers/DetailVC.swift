//
//  DetailTableVC.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 12.11.2021.
//

import Foundation
import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    let myImageView = UIImageView()
    
    var unsplashPhoto: UnsplashPhoto

    var unsplashPhotoImage: UnsplashPhoto! {
            didSet {
                let photoUrl = unsplashPhoto.urls["regular"]
                guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
                myImageView.sd_setImage(with: url, completed: nil )
            }
    }
    init(unsplashPhoto: UnsplashPhoto) {
        self.unsplashPhoto = unsplashPhoto
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    
        myImageView.contentMode = .scaleAspectFill
        myImageView.center = view.center
        myImageView.bounds = view.bounds
        view.addSubview(myImageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        unsplashPhotoImage = unsplashPhoto
    }
    
    @objc private func addBarButtonTapped() {
        print(#function)
        let alert = UIAlertController(title: "Save Images in Favorites", message: "Do you want to save?", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated:  true)
        
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [addBarButtonItem]
    }
    
}

