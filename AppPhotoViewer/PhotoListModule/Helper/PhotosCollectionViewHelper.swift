//
//  CollectionViewGenericDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotosCollectionViewEventsDelegate : class {
    func needsLoadMoreItems()
}

protocol PhotoCellProtocol : class {
    func setup(with item: PhotoItemViewModel)
    static func reuseId() -> String
}

extension PhotoCellProtocol {
    static func reuseId() -> String {
        return "GenericCellId"
    }
}

class PhotosCollectionViewHelper<CellType: PhotoCellProtocol>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, PhotosCollectionViewUpdater {

    weak var collectionView : UICollectionView?
    weak var delegate : PhotosCollectionViewEventsDelegate?
    
    var didSelectHandler : ((IndexPath, [PhotoItemViewModel]) -> ())?
    var dataSource :  [PhotoItemViewModel]
    
    init(with dataSource: [PhotoItemViewModel] = [PhotoItemViewModel]()) {
        self.dataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseId(), for: indexPath)
        
        if let photoCell = cell as? CellType {
            photoCell.setup(with: dataSource[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(indexPath, dataSource)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // For purpose to override in inherited classes.
    }
    
    func indexPath(for item: PhotoItemViewModel) -> IndexPath? {
        
        let index = dataSource.index(where: { $0 == item })
        
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        
        return nil
    }
    
    //MARK: PhotosCollectionViewUpdater
    func append(_ newElements: [PhotoItemModel]) {
        let newViewModels = newElements.compactMap({ PhotoItemViewModel(from: $0) })
        let oldCount = dataSource.count
        dataSource.append(contentsOf: newViewModels)
        self.collectionView?.collectionViewLayout.prepare()
        let indexPath : [IndexPath] = (oldCount..<dataSource.count).map({IndexPath(row: $0, section: 0)})
        self.collectionView?.insertItems(at: indexPath)
    }
    
    func allItems() -> [PhotoItemViewModel] {
        return dataSource
    }
    
    func setNewDataSource(_ newDataSource: [PhotoItemViewModel]) {
        dataSource = newDataSource
        collectionView?.reloadData()
    }
    
    func registerCells() {
        collectionView?.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseId())
    }

}
