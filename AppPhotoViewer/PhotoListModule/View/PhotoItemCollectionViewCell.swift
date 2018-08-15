//
//  PhotoItemCollectionViewCell.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit
import Nuke

class PhotoItemCollectionViewCell : UICollectionViewCell, PhotoCellProtocol {
    typealias CellGenericItem = PhotoItemViewModel
    
    let imageView : UIImageView = UIImageView(frame: CGRect())
    let likeImage : UIImageView = UIImageView(image: UIImage(named: "like"))
    let countLikesLabel : UILabel = UILabel(frame: CGRect())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateAppearenceAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with item: CellGenericItem) {
        Nuke.loadImage(with: item.smallImageUrl, into: imageView)
        countLikesLabel.text = String(item.likes)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        countLikesLabel.text = ""
    }
    
    private func configurateAppearenceAndConstraints() {
        // Configurate Main Image View
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5.0
        
        imageView.frame = bounds
        self.contentView.addSubview(imageView)
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Configurate Like Image & Count like label
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        likeImage.sizeToFit()
        contentView.addSubview(likeImage)
        likeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        likeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        
        countLikesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countLikesLabel)
        countLikesLabel.textColor = .white
        countLikesLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        countLikesLabel.textAlignment = .center
        countLikesLabel.widthAnchor.constraint(equalTo: likeImage.widthAnchor).isActive = true
        
        countLikesLabel.centerXAnchor.constraint(equalTo: likeImage.centerXAnchor).isActive = true
        countLikesLabel.centerYAnchor.constraint(equalTo: likeImage.centerYAnchor, constant: -2).isActive = true
    }
    
}
