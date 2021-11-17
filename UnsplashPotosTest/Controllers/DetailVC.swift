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
    
    let image = UIImage()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        myImageView.backgroundColor = .white
        myImageView.contentMode = .scaleToFill
        myImageView.frame.size.width = 400
        myImageView.frame.size.height = 400
        myImageView.center = self.view.center
        view.addSubview(myImageView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        unsplashPhotoImage = unsplashPhoto
    }
}
