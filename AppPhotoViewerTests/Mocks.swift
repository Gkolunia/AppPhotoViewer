//
//  Mocks.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit
@testable import AppPhotoViewer

class TestUICollectionViewMock: UICollectionView {
    
    var insertedIndexPath : [IndexPath]?
    
    override func numberOfItems(inSection section: Int) -> Int {
        return 2
    }
    
    override func insertItems(at indexPaths: [IndexPath]) {
        insertedIndexPath = indexPaths
    }
    
}

class TestVerticalCollectionViewLayoutDelegateMock : VerticalCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeFor indexPath: IndexPath) -> CGSize {
        let sizes = [CGSize(width: 300, height: 300), CGSize(width: 300, height: 900)]
        return sizes[indexPath.row]
    }
}

class TestPhotosRequestManagerMock : PhotosRequestManagerProtocol {
    
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping (Bool, PhotosContainer?, ErrorMessage?) -> ()) {
        handler(true, nil, nil)
    }
    
}

class TestUICollectionViewFlowLayoutMock: UICollectionViewFlowLayout {
    
    var prepareIsCalled = false
    
    override func prepare() {
        prepareIsCalled = true
    }
    
}

class URLSessionDataTaskStub : URLSessionDataTask {
    override func resume() { }
}

class URLSessionMock : URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(nil, nil, nil)
        let dataTask = URLSessionDataTaskStub()
        return dataTask
    }
}
