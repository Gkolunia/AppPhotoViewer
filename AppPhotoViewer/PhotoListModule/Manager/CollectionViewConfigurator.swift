//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol PhotoGenericCell : class {
    func setup(with item: PhotoItemViewModel)
}

protocol PhotosCollectionViewEventsDelegate : class {
    func needsLoadMoreItems()
    func didSelectItem(_ item: PhotoItemViewModel)
}

class CollectionViewConfigurator<T: PhotoGenericCell> : NSObject, PhotosCollectionViewConfigurator, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate : PhotosCollectionViewEventsDelegate?
    
    var dataSource :  [PhotoItemViewModel] = [PhotoItemViewModel]() {
        didSet {
            self.collectionView?.collectionViewLayout.prepare()
            let indexPath : [IndexPath] = (oldValue.count..<dataSource.count).map({IndexPath(row: $0, section: 0)})
            self.collectionView?.insertItems(at: indexPath)
        }
    }
    
    private var collectionView : UICollectionView?
    private var collectionViewLayout : UICollectionViewLayout = UICollectionViewFlowLayout()
    
    init(with layout: UICollectionViewLayout) {
        collectionViewLayout = layout
    }
    
    func configurate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(T.self, forCellWithReuseIdentifier: "PhotoItemCollectionViewCell")
        self.collectionView = collectionView
        self.collectionView?.backgroundView?.backgroundColor = .white
        self.collectionView?.backgroundColor = .white
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        return collectionViewLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCollectionViewCell", for: indexPath)
        
        if let photoCell = cell as? T {
            photoCell.setup(with: dataSource[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(dataSource[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height*0.9 {
            delegate?.needsLoadMoreItems()
        }
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
