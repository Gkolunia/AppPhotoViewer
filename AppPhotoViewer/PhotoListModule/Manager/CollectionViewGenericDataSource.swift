//
//  CollectionViewGenericDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotoGenericCell : class {
    associatedtype PhotoGenericCellItemViewModel
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
    
}

class VerticalCollectionViewDataSource : CollectionViewDataSourceAndDelegate<PhotoItemCollectionViewCell>, VerticalCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath: IndexPath) -> CGSize {
        let item = dataSource[sizeForPhotoAtIndexPath.item]
        return item.size
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height*0.9 {
            delegate?.needsLoadMoreItems()
        }
    }
}

class HorizontalCollectionViewDataSource: CollectionViewDataSourceAndDelegate<SmallPhotoItemCollectionViewCell> {
    
    var didScrollToItem : ((PhotoItemViewModel) -> ())?
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x + scrollView.frame.width > scrollView.contentSize.width*0.9 {
            delegate?.needsLoadMoreItems()
        }
        
        if let collectionView = collectionView {
            let cells = collectionView.visibleCells.filter({ (cell) -> Bool in
                let x = collectionView.bounds.width/2+collectionView.contentOffset.x - cell.bounds.width/2
                let rectInCenter = CGRect(x: x, y: 0, width: cell.bounds.width, height: cell.bounds.height)
                return rectInCenter.intersects(cell.frame)
            })
            
            guard let cell = cells.first, let index = collectionView.indexPath(for: cell) else {
                return
            }
            
            didScrollToItem?(dataSource[index.row])
        }
        
    }
}

extension VerticalCollectionViewDataSource : PhotosListShowing {
    func photosLoaded(_ array: [PhotoItemModel]) {
        dataSource.append(contentsOf: array.map( { PhotoItemViewModel(from: $0) }))
    }
}


extension HorizontalCollectionViewDataSource : PhotosListShowing {
    func photosLoaded(_ array: [PhotoItemModel]) {
        dataSource.append(contentsOf: array.map( { PhotoItemViewModel(from: $0) }))
    }
}
