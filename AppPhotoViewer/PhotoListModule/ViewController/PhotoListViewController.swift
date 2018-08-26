//
//  PhotoListViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol ListEventsHandling : EventsHandling {
    func loadMore(in view: ViewPartialReloadingItems)
}

/// Abstraction of collection view updater, provides interface to update data source for collection view.
protocol PhotosListDataProvider : ListDataProvider where Element == PhotoItemViewModel {
    
}

/// Abstraction of cell for PhotoItemViewModel
protocol PhotoCellProtocol : GenericReuseView {
    func setup(with item: PhotoItemViewModel)
}

class PhotoListViewController<DataProvider, EventsHandling, CellType> : UIViewController, ViewLoading, ViewDataReloading, ViewPartialReloadingItems, UICollectionViewDelegate, UICollectionViewDataSource
        where
            DataProvider: PhotosListDataProvider,
            EventsHandling: ListEventsHandling,
            CellType: UICollectionViewCell & PhotoCellProtocol {
    
    let collectionView: UICollectionView
    let dataProvider: DataProvider
    let eventsHandler: EventsHandling
    
    var isLoading: Bool = false
    
    init(_ eventsHandler: EventsHandling, _ dataProvider: DataProvider, _ layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.dataProvider = dataProvider
        self.eventsHandler = eventsHandler
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundView?.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseIdentifier())
        view.addSubview(collectionView)
        
        eventsHandler.loadDataIfNeeded(in: self)
        
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func insertNewItems(at indexPaths: [IndexPath]) {
        collectionView.collectionViewLayout.prepare()
        collectionView.insertItems(at: indexPaths)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CellType = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(with: dataProvider.item(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let leftToTheEnd = dataProvider.count() - indexPath.row
        if leftToTheEnd<10 {
            eventsHandler.loadMore(in: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
    
    
}
