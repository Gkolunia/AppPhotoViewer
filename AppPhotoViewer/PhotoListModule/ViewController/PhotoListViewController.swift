//
//  PhotoListViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotosLoader {
    func loadMore()
}

protocol PhotosCollectionViewUpdater : UICollectionViewDelegate, UICollectionViewDataSource {
    func append(_ newElements: [PhotoItemModel])
    func collectionViewCellType() -> (cellClass: AnyClass, cellId: String)
}

class PhotoListViewController : UIViewController, PhotosCollectionViewEventsDelegate {

    let photosLoader : PhotosLoader
    let collectionView : UICollectionView
    let collectionViewHelper : PhotosCollectionViewUpdater
    
    init(_ loader: PhotosLoader, _ collectionViewHelper: PhotosCollectionViewUpdater, _ layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.photosLoader = loader
        self.collectionViewHelper = collectionViewHelper
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
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
        collectionView.register(collectionViewHelper.collectionViewCellType().cellClass, forCellWithReuseIdentifier: collectionViewHelper.collectionViewCellType().cellId)
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
