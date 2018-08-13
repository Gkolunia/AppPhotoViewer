//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotosCollectionViewEventsDelegate : class {
    func needsLoadMoreItems()
}

class CollectionViewConfigurator : NSObject, PhotosCollectionViewConfigurator {
    
    weak var delegate : PhotosCollectionViewEventsDelegate?
    
    var dataSource :  [PhotoItemViewModel] = [PhotoItemViewModel]() {
        didSet {
            self.collectionView?.collectionViewLayout.prepare()
            let indexPath : [IndexPath] = (oldValue.count..<dataSource.count).map({IndexPath(row: $0, section: 0)})
            self.collectionView?.insertItems(at: indexPath)
        }
    }
    
    private var collectionView : UICollectionView?
    
    func configurate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoItemCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoItemCollectionViewCell")
        self.collectionView = collectionView
        self.collectionView?.backgroundView?.backgroundColor = .white
        self.collectionView?.backgroundColor = .white
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        let layout = VerticalCollectionViewLayout()
        layout.delegate = self
        return layout
    }
    
}

extension CollectionViewConfigurator : VerticalCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath: IndexPath) -> CGSize {
        let item = dataSource[sizeForPhotoAtIndexPath.item]
        return item.size
    }
    
}

extension CollectionViewConfigurator : PhotosListShowing {
    
    func photosLoaded(_ array: [PhotoItemModel]) {
        dataSource.append(contentsOf: array.map( { PhotoItemViewModel(from: $0) }))
    }
    
}

extension CollectionViewConfigurator : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCollectionViewCell", for: indexPath)
        
        if let photoCell = cell as? PhotoItemCollectionViewCell {
            photoCell.setup(dataSource[indexPath.row])
        }
        return cell
    }
    
}

extension CollectionViewConfigurator : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height*0.5 {
            delegate?.needsLoadMoreItems()
        }
        
    }
    
    
}
