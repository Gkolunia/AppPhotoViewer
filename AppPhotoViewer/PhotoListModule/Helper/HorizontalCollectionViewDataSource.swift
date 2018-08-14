//
//  HorizontalCollectionViewDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

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

extension HorizontalCollectionViewDataSource : PhotosListShowing {
    func photosLoaded(_ array: [PhotoItemModel]) {
        dataSource.append(contentsOf: array.map( { PhotoItemViewModel(from: $0) }))
    }
}
