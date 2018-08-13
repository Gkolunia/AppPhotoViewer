//
//  PhotoItemCollectionViewCell.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class PhotoItemCollectionViewCell : UICollectionViewCell {
    
    let imageView : ImageView = ImageView(frame: CGRect())
    
    override init(frame: CGRect) {
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        super.init(frame: frame)
        imageView.frame = bounds
        self.contentView.backgroundColor = .red
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: PhotoItemModel) {
        imageView.loadImageFromURL(url: item.urls.full)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelLoading()
        imageView.image = nil
    }
    
}
