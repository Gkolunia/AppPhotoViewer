//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class CollectionViewConfigurator : NSObject, PhotosCollectionViewConfigurator {
    
    var dataSource : [PhotoItemModel]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    private var collectionView : UICollectionView?
    
    func configurate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoItemCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoItemCollectionViewCell")
        self.collectionView = collectionView
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        let layout = VerticalCollectionViewLayout()
        layout.delegate = self
        return layout
    }
    
}

extension CollectionViewConfigurator : VerticalCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath: IndexPath) -> CGSize {
        if let dataSource = dataSource {
            let item = dataSource[sizeForPhotoAtIndexPath.item]
            return CGSize(width: item.width, height: item.height)
        }
        return CGSize()
    }
    
}

extension CollectionViewConfigurator : PhotosListShowing {
    
    func photosLoaded(_ array: [PhotoItemModel]) {
        dataSource = array
    }
    
}

extension CollectionViewConfigurator : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCollectionViewCell", for: indexPath)
        
        if let photoCell = cell as? PhotoItemCollectionViewCell, let dataSource = dataSource {
            photoCell.setup(dataSource[indexPath.row])
        }
        return cell
    }
    
    
}
