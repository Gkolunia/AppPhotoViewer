//
//  PhotoListViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotosCollectionViewConfigurator {
    func configurate(_ collectionView: UICollectionView)
    func collectionLayout() -> UICollectionViewLayout
}

protocol PhotosLoader {
    func loadMore()
}

class PhotoListViewController : UIViewController, GenericCollectionViewEventsDelegate {

    let collectionViewConfigurator : PhotosCollectionViewConfigurator
    let photosLoader : PhotosLoader
    weak var collectionView : UICollectionView?
    
    init(_ configurator:PhotosCollectionViewConfigurator, _ loader: PhotosLoader) {
        collectionViewConfigurator = configurator
        photosLoader = loader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Photos"
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewConfigurator.collectionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionViewConfigurator.configurate(collectionView)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func needsLoadMoreItems() {
        photosLoader.loadMore()
    }
    
}
