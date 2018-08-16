//
//  HorizontalCollectionViewLayoutTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

class HorizontalCollectionViewLayoutTests : XCTestCase {
    
    func testLayoutAttributes() {
        
        let layout = HorizontalCollectionViewLayout()
        let collectionView = TestUICollectionViewMock(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.collectionViewLayout.prepare()
        
        let attributesFirstRow = layout.layoutAttributesForItem(at: IndexPath(row: 0, section: 0))
        let attributesSecondRow = layout.layoutAttributesForItem(at: IndexPath(row: 1, section: 0))
        
        let frameForFirstRow = CGRect(x: 50.5, y: 0, width: 50, height: 100)
        XCTAssertTrue(attributesFirstRow?.frame == frameForFirstRow, "Wrong layout")
        
        let frameForSecondRow = CGRect(x: 101.5, y: 0, width: 50, height: 100)
        XCTAssertTrue(attributesSecondRow?.frame == frameForSecondRow, "Wrong layout")
        
    }
    
}
