//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class CollectionViewConfigurator<T: PhotoGenericCell> : NSObject, PhotosCollectionViewConfigurator  {
    
    var collectionViewDataSource : CollectionViewDataSourceAndDelegate<T>
    
    private var collectionView : UICollectionView?
    private var collectionViewLayout : UICollectionViewLayout = UICollectionViewFlowLayout()
    
    init(with layout: UICollectionViewLayout, _ dataSourceAndDelegate: CollectionViewDataSourceAndDelegate<T>) {
        collectionViewLayout = layout
        collectionViewDataSource = dataSourceAndDelegate
    }
    
    func configurate(_ collectionView: UICollectionView) {
        
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDataSource
        collectionView.register(T.self, forCellWithReuseIdentifier: "PhotoItemCollectionViewCell")
        self.collectionView = collectionView
        self.collectionView?.backgroundView?.backgroundColor = .white
        self.collectionView?.backgroundColor = .white
        
        collectionViewDataSource.collectionView = collectionView
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        return collectionViewLayout
    }
 
}
