//
//  PhotoItemViewModelTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

struct TestPhotoModelStubs {
    static let photoModel1 = PhotoItemModel(id: "id", urls: PhotoUrls(full: URL(fileURLWithPath: "http://url.com"), small: URL(fileURLWithPath: "http://url.com")),
                                     likes: 2, width: 20, height: 30, tags: [Tag(title: "First tag"), Tag(title: "SecondTag")])
    
    static let photoModel2 = PhotoItemModel(id: "id2", urls: PhotoUrls(full: URL(fileURLWithPath: "http://url.com"), small: URL(fileURLWithPath: "http://url.com")),
                                     likes: 2, width: 220, height: 150, tags: [Tag(title: "First tag"), Tag(title: "SecondTag")])
}


class PhotoItemViewModelTests: XCTestCase {

    func testCreateViewModel() {

        let viewModel = PhotoItemViewModel(from: TestPhotoModelStubs.photoModel1)
        
        XCTAssertTrue(viewModel.size.equalTo(CGSize(width: 20, height: 30)), "Wrong size")
        XCTAssertTrue(viewModel.tagTitle == "First tag", "Wrong tag")
        
    }
    
    func testEqualObjects() {
        
        let viewModel1 = PhotoItemViewModel(from: TestPhotoModelStubs.photoModel1)
        let viewModel2 = PhotoItemViewModel(from: TestPhotoModelStubs.photoModel1)
        
        XCTAssertTrue(viewModel1 == viewModel2, "Wrong implementation of Equatable")
        
    }
    
    func testUnequalObjects() {
        
        let viewModel1 = PhotoItemViewModel(from: TestPhotoModelStubs.photoModel1)
        let viewModel2 = PhotoItemViewModel(from: TestPhotoModelStubs.photoModel2)
        
        XCTAssertTrue(viewModel1 != viewModel2, "Wrong implementation of Equatable")
        
    }
    
}
