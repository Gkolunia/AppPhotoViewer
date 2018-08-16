//
//  PhotosPaginationLoaderTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

class PhotosPaginationLoaderTests: XCTestCase {
    
    func testPaginationState() {
        
        let paginationLoader = PhotosPaginationLoader(TestPhotosRequestManagerMock())
        
        paginationLoader.initialLoadPhotos()
        
        XCTAssertTrue(paginationLoader.currentPage == 1, "Wrong state, should be 1")
        XCTAssertFalse(paginationLoader.isLoading, "Should be true")
        
        paginationLoader.loadMore()
        XCTAssertTrue(paginationLoader.currentPage == 2, "Wrong state, should be 2")
        XCTAssertFalse(paginationLoader.isLoading, "Should be true")
        
        
    }
    
}
