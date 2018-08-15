//
//  VerticalCollectionViewDataSource.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class VerticalCollectionViewHelper : GenericCollectionViewHelper<PhotoItemCollectionViewCell>, VerticalCollectionViewLayoutDelegate {
    
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

//extension VerticalCollectionViewHelper : PhotosListShowing {
//    func photosLoaded(_ array: [PhotoItemModel]) {
//        dataSource.append(contentsOf: array.map( { PhotoItemViewModel(from: $0) }))
//    }
//}

