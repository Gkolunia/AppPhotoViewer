//
//  CollectionViewGenericDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

typealias PhotosListCallBack = ([PhotoItemModel]?) -> ()

protocol PhotosPaginationListDatasource {
    func initialLoadPhotos(_ handler: @escaping PhotosListCallBack)
    func loadMoreFromCurrentPage(_ handler: @escaping PhotosListCallBack)
}

protocol ViewPartialReloadingItems: class {
    func insertNewItems(at indexPaths: [IndexPath])
}


class PhotosListPresenter: NSObject, PhotosListDataProvider, ListEventsHandling {

    private var items:  [PhotoItemViewModel]
    private var photosDatasource: PhotosPaginationListDatasource
    
    init(with items: [PhotoItemViewModel] = [PhotoItemViewModel](), _ photosDatasource: PhotosPaginationListDatasource) {
        self.items = items
        self.photosDatasource = photosDatasource
        
    }
    
    func count() -> Int {
        return 0
    }
    
    func item(at index: Int) -> PhotoItemViewModel {
        return items[index]
    }
    
    func loadMore(in view: ViewPartialReloadingItems) {
        photosDatasource.loadMoreFromCurrentPage { (newItems) in
            if let newItems = newItems {
                let newViewModels = newItems.compactMap({ PhotoItemViewModel(from: $0) })
                let oldCount = self.items.count
                self.items.append(contentsOf: newViewModels)
                let indexPath : [IndexPath] = (oldCount..<self.items.count).map({IndexPath(row: $0, section: 0)})
                view.insertNewItems(at: indexPath)
            }
        }
    }
    
    func loadData(in view: ViewDataReloading & ViewLoading) {
        view.isLoading = true
        photosDatasource.initialLoadPhotos { (items) in
            if let items = items {
                self.items = items.compactMap({ PhotoItemViewModel(from: $0) })
                view.reloadData()
            }
            view.isLoading = false
        }
    }
    
//    //MARK: UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseId(), for: indexPath)
//
//        if let photoCell = cell as? CellType {
//            photoCell.setup(with: dataSource[indexPath.row])
//        }
//        return cell
//    }
//
//    //Mark: UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelectHandler?(indexPath, dataSource)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // For purpose to override in inherited classes.
//    }
    
    //MARK: PhotosCollectionViewUpdater
//    func append(_ newElements: [PhotoItemModel]) {
//        let newViewModels = newElements.compactMap({ PhotoItemViewModel(from: $0) })
//        let oldCount = dataSource.count
//        dataSource.append(contentsOf: newViewModels)
//        self.collectionView?.collectionViewLayout.prepare()
//        let indexPath : [IndexPath] = (oldCount..<dataSource.count).map({IndexPath(row: $0, section: 0)})
//        self.collectionView?.insertItems(at: indexPath)
//    }
    
//    func allItems() -> [PhotoItemViewModel] {
//        return dataSource
//    }
    
//    func setNewDataSource(_ newDataSource: [PhotoItemViewModel]) {
//        dataSource = newDataSource
//        collectionView?.reloadData()
//    }
    
//    func registerCells() {
//        collectionView?.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseId())
//    }

}
