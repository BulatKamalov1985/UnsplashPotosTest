//
//  ImageTableViewCell.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 12.11.2021.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell {

    var imageTableView = UIImageView()
    var imageTitleLabel = UILabel()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            imageTitleLabel.text =  unsplashPhoto.user.name
            let photoUrl = unsplashPhoto.urls["small"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            imageTableView.sd_setImage(with: url, completed: nil )
        }
    }
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageTableView)
        addSubview(imageTitleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        imageTableView.layer.cornerRadius = 10
        imageTableView.clipsToBounds = true
        imageTableView.contentMode = .scaleAspectFill
    }
    
    func configureTitleLabel() {
        imageTitleLabel.numberOfLines = 0
        imageTitleLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func setImageConstraints() {
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        imageTableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        imageTableView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageTableView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        imageTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    func setTitleLabelConstraints() {
        imageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageTitleLabel.leadingAnchor.constraint(equalTo: imageTableView.trailingAnchor, constant: 20).isActive = true
        imageTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
