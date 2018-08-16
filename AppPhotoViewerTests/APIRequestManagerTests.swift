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
    
    struct ReturnedModelStub : Codable {
        
    }
    
    class URLSessionDataTaskStub : URLSessionDataTask {
        
        override func resume() {
            
        }
        
    }
    
    func testFailureDoRequest() {
        
        struct TestStruct : Codable {
            
        }
        
        class URLSessionMock : URLSession {
            override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
                completionHandler(nil, nil, nil)
                let dataTask = URLSessionDataTaskStub()
                return dataTask
            }
        }
        
        let apiManager = APIRequestManager(with: URLRequestBuilder(with: APIConstants(host, scheme, httpHeaderFields)), urlSession: URLSessionMock())
        apiManager.makeAndDoRequest("", nil, RequestType.get) { (success, response : TestStruct?, error) in
            XCTAssertFalse(success, "Tested failure request")
        }

    }

}
