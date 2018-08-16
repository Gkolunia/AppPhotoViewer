//
//  APIRequestManager.swift
//  AppPhotoViewerTests
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import AppPhotoViewer

class APIRequestManagerTests: XCTestCase {
    
    func testFailureDoRequest() {
        
        struct TestStruct : Codable { }
        
        let apiManager = APIRequestManager(with: URLRequestBuilder(with: APIConstants(host, scheme, httpHeaderFields)), urlSession: URLSessionMock())
        apiManager.makeAndDoRequest("", nil, RequestType.get) { (success, response : TestStruct?, error) in
            XCTAssertFalse(success, "Tested failure request")
        }

    }

}
