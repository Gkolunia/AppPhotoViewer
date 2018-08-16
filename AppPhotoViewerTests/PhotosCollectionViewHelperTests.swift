//
//  PhotosCollectionViewHelperTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

class PhotosCollectionViewHelperTests: XCTestCase {
    
    
    func testAppendFunction() {
        
        let helper = PhotosCollectionViewHelper<PhotoItemCollectionViewCell>()
        let layout = TestUICollectionViewFlowLayoutMock()
        let collection = TestUICollectionViewMock(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        
        helper.collectionView = collection
        
        helper.append([TestPhotoModelStubs.photoModel1])
        
        XCTAssertTrue(helper.dataSource[0] == PhotoItemViewModel(from: TestPhotoModelStubs.photoModel1), "Wrong appended item")
        XCTAssertTrue(layout.prepareIsCalled, "Prepared function should be called to recalculate layout")
        XCTAssertTrue(collection.insertedIndexPath != nil, "New items should be inserted")
        
    }
    
}
