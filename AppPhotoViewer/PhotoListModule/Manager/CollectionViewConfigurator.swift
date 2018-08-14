//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class CollectionViewConfigurator<CellType: GenericCell> : NSObject, PhotosCollectionViewConfigurator  {
    
    var collectionViewHelper : GenericCollectionViewHelper<CellType>
    
    private var collectionView : UICollectionView?
    private var collectionViewLayout : UICollectionViewLayout = UICollectionViewFlowLayout()
    
    init(with layout: UICollectionViewLayout, _ dataSourceAndDelegate: GenericCollectionViewHelper<CellType>) {
        collectionViewLayout = layout
        collectionViewHelper = dataSourceAndDelegate
    }
    
    func configurate(_ collectionView: UICollectionView) {
        
        collectionView.dataSource = collectionViewHelper
        collectionView.delegate = collectionViewHelper
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseId())
        self.collectionView = collectionView
        self.collectionView?.backgroundView?.backgroundColor = .white
        self.collectionView?.backgroundColor = .white
        
        collectionViewHelper.collectionView = collectionView
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        return collectionViewLayout
    }
 
}
