//
//  URLRequestBuilderTests.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/15/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

struct TestServiceConstants : ServiceConstants {
    let host = "test.com"
    let scheme = "https"
    let httpHeaderFields : [String : String] = ["Header" : "Header"]
}

let testHttpParams = ["Param1" : "Value1"]
let pathRequest = "/path"
let resultUrlString = "https://test.com/path?Param1=Value1"

class URLRequestBuilderTests: XCTestCase {
    
    var builder = URLRequestBuilder(with: TestServiceConstants())
    
    func testBuildExample() {
        let urlRequest = builder.setParams(testHttpParams).setPath(pathRequest).setReuestType(.post).build()
        XCTAssert(urlRequest?.httpMethod == RequestType.post.rawValue)
        XCTAssert(urlRequest?.cachePolicy == URLRequest.CachePolicy.reloadIgnoringCacheData)
        XCTAssert(urlRequest?.url?.absoluteString == resultUrlString)
        
    }
    
}
