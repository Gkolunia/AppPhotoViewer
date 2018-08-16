//
//  VerticalCollectionViewLayoutTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

class VerticalCollectionViewLayoutTests: XCTestCase {
    
    class TestVerticalCollectionViewLayoutDelegate : VerticalCollectionViewLayoutDelegate {
        
        func collectionView(_ collectionView: UICollectionView, sizeFor indexPath: IndexPath) -> CGSize {
            let sizes = [CGSize(width: 300, height: 300), CGSize(width: 300, height: 900)]
            return sizes[indexPath.row]
        }
    }
    
    class TestUICollectionView: UICollectionView {
        
        override func numberOfItems(inSection section: Int) -> Int {
            return 2
        }
        
    }
    
    func testLayoutAttributes() {
        
        let layout = VerticalCollectionViewLayout()
        let layoutDelegate = TestVerticalCollectionViewLayoutDelegate()
        layout.delegate = layoutDelegate
        let collectionView = TestUICollectionView(frame: CGRect(x: 0, y: 0, width: 150, height: 400), collectionViewLayout: layout)
        layout.prepare()
        
        let attributesFirstRow = layout.layoutAttributesForItem(at: IndexPath(row: 0, section: 0))
        let attributesSecondRow = layout.layoutAttributesForItem(at: IndexPath(row: 1, section: 0))
        
        let frameForFirstRow = CGRect(x: 6.0, y: 6.0, width: 63.0, height: 162.0)
        XCTAssertTrue(attributesFirstRow?.frame == frameForFirstRow, "Wrong layout")
        
        let frameForSecondRow = CGRect(x: 81.0, y: 6.0, width: 63.0, height: 162.0)
        XCTAssertTrue(attributesSecondRow?.frame == frameForSecondRow, "Wrong layout")
        
    }
    
}
