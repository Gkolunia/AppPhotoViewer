//
//  HorizontalCollectionViewLayout.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Layout for representing data horizontaly in collection view.
class HorizontalCollectionViewLayout : UICollectionViewLayout {
    
    private var cellPadding : CGFloat = 0.5
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentWidth : CGFloat = 0
    
    private var contentHeight : CGFloat {
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
        
        guard let collectionView = collectionView else {
            return
        }

        let widthCell = cellPadding*2 + collectionView.frame.size.height/2
        let heightCell = collectionView.frame.size.height
        // Starts all items shows with offset.
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
        
        // Make offset at the end of the list.
//        contentWidth = contentWidth+collectionView.bounds.width/2
        
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
