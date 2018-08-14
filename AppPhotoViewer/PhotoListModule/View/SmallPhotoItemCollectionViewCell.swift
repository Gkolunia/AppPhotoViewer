//
//  SmallPhotoItemCollectionViewCell.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit
import Nuke

class SmallPhotoItemCollectionViewCell : UICollectionViewCell, GenericCell {
    
    typealias CellGenericItem = PhotoItemViewModel
    
    let imageView : UIImageView = UIImageView(frame: CGRect())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateAppearenceAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with item: CellGenericItem) {
        Nuke.loadImage(with: item.smallImageUrl, into: imageView)
    }
    
    private func configurateAppearenceAndConstraints() {
        // Configurate Main Image View
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = bounds
        
        self.contentView.addSubview(imageView)
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
