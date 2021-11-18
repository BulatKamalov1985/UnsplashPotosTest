//
//  ImageCollectionViewCell.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 14.11.2021.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifierCV = "ImageCell"
    
    private let favoriteMark: UIImageView = {
        let image = UIImage(systemName: "heart")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }() 
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["small"]
            guard let imageUrl = photoUrl,
                  let url = URL(string: imageUrl)
            else { return }
            photoImageView.sd_setImage(with: url, completed: nil )
        }
    }
    
    override var isSelected: Bool {
        didSet {
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        photoImageView.frame = contentView.bounds
        setupPhotoImageView()
        setupFavoriteMark()
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been imlemented")
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupFavoriteMark() {
        addSubview(favoriteMark)
        favoriteMark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor,
                                               constant: -8).isActive = true
        favoriteMark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor,
                                             constant: -8).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = CGRect(x: 5,
                                 y: 5,
                                 width: contentView.frame.size.width-10,
                                 height: contentView.frame.size.height-10)
    }
}
