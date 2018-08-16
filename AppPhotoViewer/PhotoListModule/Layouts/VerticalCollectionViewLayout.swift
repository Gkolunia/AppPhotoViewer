//
//  VerticalCollectionViewLayout.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Abstraction of delegate which can return size of content of image, is used to define which orientation of the cell should be used - portrait or landscape.
protocol VerticalCollectionViewLayoutDelegate : class {
    func collectionView(_ collectionView: UICollectionView, sizeFor indexPath: IndexPath) -> CGSize
}

/// Layout vertically represent cells and depends on size of image used different orientation of a cell.
class VerticalCollectionViewLayout : UICollectionViewLayout {
    
    weak var delegate: VerticalCollectionViewLayoutDelegate?
    
    private var numberOfColumns = 2
    private var cellPadding : CGFloat = 6
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    
    private var contentWidth : CGFloat {
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
        
        guard let collectionView = collectionView, let delegate = delegate else {
            return
        }
        
        cache.removeAll()
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column)*columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let sizePhoto = delegate.collectionView(collectionView, sizeFor: indexPath)
            
            var heightCell = cellPadding*2 + columnWidth
            if sizePhoto.height*1.3 > sizePhoto.width {
                heightCell = cellPadding*4 + columnWidth*2
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
