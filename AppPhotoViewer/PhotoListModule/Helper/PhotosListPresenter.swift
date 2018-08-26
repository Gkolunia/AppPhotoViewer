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

protocol CoordinatorInput: class {
    func doSelect(with item: PhotoItemViewModel)
}

class PhotosListPresenter: NSObject, PhotosListDataProvider, VerticalListEventsHandler {

    private var items:  [PhotoItemViewModel]
    private var photosDatasource: PhotosPaginationListDatasource
    weak var input: CoordinatorInput?
    
    init(with items: [PhotoItemViewModel] = [PhotoItemViewModel](), _ photosDatasource: PhotosPaginationListDatasource) {
        self.items = items
        self.photosDatasource = photosDatasource
    }
    
    func count() -> Int {
        return items.count
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
    
    func loadDataIfNeeded(in view: ViewDataReloading & ViewLoading) {
        if !items.isEmpty {
            return
        }
        view.isLoading = true
        photosDatasource.initialLoadPhotos { (items) in
            if let items = items {
                self.items = items.compactMap({ PhotoItemViewModel(from: $0) })
                view.reloadData()
            }
            view.isLoading = false
        }
    }
    
    func didSelect(at index: Int) {
        input?.doSelect(with: items[index])
    }

}
