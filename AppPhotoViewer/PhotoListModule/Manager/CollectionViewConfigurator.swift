//
//  CollectionViewConfigurator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit


class HorizontalCollectionViewLayout : UICollectionViewLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        
        print("My Layout reload")
        
    }
    
    
}

protocol VerticalCollectionViewLayoutDelegate : class {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath: IndexPath) -> CGSize
}

class VerticalCollectionViewLayout : UICollectionViewLayout {
    
    weak var delegate: VerticalCollectionViewLayoutDelegate?
    
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding : CGFloat = 6
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight : CGFloat = 0
    
    fileprivate var contentWidth : CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView, let delegate = delegate else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column)*columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let sizePhoto = delegate.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath)
            
            var heightCell = cellPadding*2 + columnWidth
            if sizePhoto.height*1.3 > sizePhoto.width {
                heightCell = cellPadding*2 + columnWidth*2
            }
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: heightCell)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + heightCell
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
            
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

class CollectionViewConfigurator : NSObject, PhotosCollectionViewConfigurator {
    
    func configurate(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
    
}

extension CollectionViewConfigurator : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    
}
