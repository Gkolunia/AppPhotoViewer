//
//  HorizontalCollectionViewLayout.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class HorizontalCollectionViewLayout : UICollectionViewLayout {
    
    fileprivate var cellPadding : CGFloat = 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentWidth : CGFloat = 0
    
    fileprivate var contentHeight : CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.bounds.width/2)
        
        let widthCell = cellPadding*2 + collectionView.frame.size.height/2
        let heightCell = collectionView.frame.size.height
        var xOffset : CGFloat = collectionView.frame.size.width/2
        
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let frame = CGRect(x: xOffset, y: 0, width: widthCell, height: heightCell)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentWidth = max(contentWidth, frame.maxX)
            
            xOffset = xOffset + widthCell

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
