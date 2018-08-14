//
//  CollectionViewGenericDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotoGenericCell : class {
    associatedtype PhotoGenericCellItemViewModel : EquatableItem
    func setup(with item: PhotoGenericCellItemViewModel)
}

protocol PhotosCollectionViewEventsDelegate : class {
    func needsLoadMoreItems()
}

class CollectionViewDataSourceAndDelegate<CellType: PhotoGenericCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    weak var collectionView : UICollectionView?
    
    var didSelectHandler : ((CellType.PhotoGenericCellItemViewModel) -> ())?
    weak var delegate : PhotosCollectionViewEventsDelegate?
    
    var dataSource :  [CellType.PhotoGenericCellItemViewModel] = [CellType.PhotoGenericCellItemViewModel]() {
        didSet {
            self.collectionView?.collectionViewLayout.prepare()
            let indexPath : [IndexPath] = (oldValue.count..<dataSource.count).map({IndexPath(row: $0, section: 0)})
            self.collectionView?.insertItems(at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCollectionViewCell", for: indexPath)
        
        if let photoCell = cell as? CellType {
            photoCell.setup(with: dataSource[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(dataSource[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // For purpose to override in inherited classes.
    }
    
    func indexPath(for item: CellType.PhotoGenericCellItemViewModel) -> IndexPath? {
        
        let index = dataSource.index { (itemInArray) -> Bool in
            return itemInArray.id == item.id
        }
        
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        
        return nil
    }
    
}
