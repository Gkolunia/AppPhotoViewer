//
//  PhotoListViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Abstraction of photos loader is needed to load more photos when collection view is scrolled to the end of the list.
protocol PhotosLoader {
    func loadMore()
}

/// Abstraction of collection view updater, provides interface to update data source for collection view.
protocol PhotosCollectionViewUpdater : UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView : UICollectionView? { get set }
    
    /// Append new items to existing data source and also updates collection view.
    ///
    /// - Parameter newElements: only new elements
    func append(_ newElements: [PhotoItemModel])
    
    /// Method which register cells for current colletion view
    func registerCells()
    func allItems() -> [PhotoItemViewModel]
    
    /// Set completely mew dta source and reloads collection view.
    func setNewDataSource(_ newDataSource:[PhotoItemViewModel])
}

class PhotoListViewController : UIViewController, PhotosCollectionViewEventsDelegate {

    let photosLoader : PhotosLoader
    let collectionView : UICollectionView
    let collectionViewHelper : PhotosCollectionViewUpdater
    
    init(_ loader: PhotosLoader, _ collectionViewHelper: PhotosCollectionViewUpdater, _ layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.photosLoader = loader
        self.collectionViewHelper = collectionViewHelper
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionViewHelper.collectionView = collectionView
        collectionViewHelper.registerCells()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Photos"
        
        collectionView.frame = self.view.bounds
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = collectionViewHelper
        collectionView.delegate = collectionViewHelper
        collectionView.backgroundView?.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    func needsLoadMoreItems() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photosLoader.loadMore()
        
    }
    
}

extension PhotoListViewController : PhotosListShowing {
    
    func photosLoaded(_ newElements: [PhotoItemModel]) {
        collectionViewHelper.append(newElements)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
