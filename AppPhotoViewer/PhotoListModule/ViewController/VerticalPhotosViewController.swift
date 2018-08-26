//
//  VerticalPhotosViewController.swift
//  AppPhotoViewer
//
//  Created by Mykola_Hrybeniuk on 8/26/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol VerticalListEventsHandler: ListEventsHandling {
    func didSelect(at index: Int)
}

class VerticalPhotosViewController<DataProvider, EventsHandling>: PhotoListViewController<DataProvider, EventsHandling, PhotoItemCollectionViewCell>
    where
    DataProvider: PhotosListDataProvider,
    EventsHandling: VerticalListEventsHandler
{
    
    
    init(_ eventsHandler: EventsHandling, _ dataProvider: DataProvider, _ layout: VerticalCollectionViewLayout) {
        super.init(eventsHandler, dataProvider, layout)
        layout.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventsHandler.didSelect(at: indexPath.row)
    }
    
}

extension VerticalPhotosViewController: VerticalCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeFor indexPath: IndexPath) -> CGSize {
        let item = dataProvider.item(at: indexPath.row)
        return item.size
    }
    
}
