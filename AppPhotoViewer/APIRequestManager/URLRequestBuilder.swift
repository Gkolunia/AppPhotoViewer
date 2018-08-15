//
//  URLRequestBuilder.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/11/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

fileprivate let unsplash = "api.unsplash.com"
fileprivate let unsplashScheme = "https"
fileprivate let unsplasHeaderFields : [String : String] = ["AcceptVersion" : "v1",
                                                           "Authorization" : "Client-ID c1717fdbec79a4749bc691e090050acdfbea76fcd9d29c1fa9a5e8bacb83df46"]

struct APIConstants {
    let host : String
    let scheme : String
    let httpHeaderFields : [String : String]
    
    init(_ hostName: String, _ hostScheme: String, _ headerFields: [String : String]) {
        host = hostName
        scheme = hostScheme
        httpHeaderFields = headerFields
    }
}

protocol URLRequestBuilderProtocol {
    func build() -> URLRequest?
    func setPath(_ path: String) -> Self
    func setParams(_ httpParams: [String : String]?) -> Self
    func setReuestType(_ type: RequestType) -> Self
}

class URLRequestBuilder : URLRequestBuilderProtocol {
    
    private var urlComponents : URLComponents
    private var requestType : RequestType = .get
    private var httpHeaderFields : [String : String]?
    
    init(with hostParams: APIConstants = APIConstants(unsplash, unsplashScheme, unsplasHeaderFields)) {
        urlComponents = URLComponents()
        urlComponents.scheme = hostParams.scheme
        urlComponents.host = hostParams.host
        httpHeaderFields = hostParams.httpHeaderFields
    }
    
    func build() -> URLRequest? {
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = requestType.rawValue
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
            request.allHTTPHeaderFields = httpHeaderFields
            
            return request
        }
        
        return nil
    }
    
    func setPath(_ path: String) -> Self {
        urlComponents.path = path
        return self
    }
    
    func setParams(_ httpParams: [String : String]?) -> Self {
        if let params = httpParams, params.count > 0 {
            var queryItems = [URLQueryItem]()
            for key in params.keys {
                queryItems.append(URLQueryItem(name: key, value: params[key]))
            }
            urlComponents.queryItems = queryItems
        }
        return self
    }
    
    func setReuestType(_ type: RequestType) -> Self {
        requestType = type
        return self
    }

}
