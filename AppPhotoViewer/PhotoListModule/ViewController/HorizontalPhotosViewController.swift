//
//  HorizontalPhotosViewController.swift
//  AppPhotoViewer
//
//  Created by Mykola_Hrybeniuk on 8/26/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class HorizontalPhotosViewController<DataProvider, EventsHandling>: PhotoListViewController<DataProvider, EventsHandling, SmallPhotoItemCollectionViewCell>
    where
    DataProvider: PhotosListDataProvider,
    EventsHandling: ListEventsHandling
{
    
    var didScrollToItem : ((IndexPath, PhotoItemViewModel) -> ())?

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cells = collectionView.visibleCells.filter({ (cell) -> Bool in
            let x = collectionView.bounds.width/2+collectionView.contentOffset.x - cell.bounds.width/2
            let rectInCenter = CGRect(x: x, y: 0, width: cell.bounds.width, height: cell.bounds.height)
            return rectInCenter.intersects(cell.frame)
        })

        guard let cell = cells.first, let index = collectionView.indexPath(for: cell) else {
            return
        }

        didScrollToItem?(index, dataProvider.item(at: index.row))

    }
    
}
