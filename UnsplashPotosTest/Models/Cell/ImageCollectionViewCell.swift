//
//  ImageCollectionViewCell.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 14.11.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifierCV = "ImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.rectangle")
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been imlemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5,
                                 y: 5,
                                 width: contentView.frame.size.width-10,
                                 height: contentView.frame.size.height-10)
    }
}
