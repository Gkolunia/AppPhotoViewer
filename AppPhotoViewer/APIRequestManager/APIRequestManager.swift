//
//  APIRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/11/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

typealias ErrorMessage = (title: String, description: String?)
typealias CompletionHandler<T> = (_ succes: Bool, _ object: [T]?,_ errorMessage: ErrorMessage?) -> ()

/// Base errors for network service
fileprivate struct NetworkDomainErrors {
    static let noInternetConnection : ErrorMessage = ("No Internet Connection!", "Please connect to WiFi to see the latest data.")
    static let somethingGoesWrong : ErrorMessage = ("Something goes wrong.", nil)
}

class APIRequestManager {

    let builder: URLRequestBuilderProtocol
    let session: URLSession
    
    init(with urlBuilder: URLRequestBuilderProtocol, urlSession: URLSession = URLSession.shared) {
        builder = urlBuilder
        session = urlSession
    }
    
    /// Executes url request which is returned from makeRequest function.
    ///
    /// - Parameters:
    ///   - urlString: path of API URL
    ///   - httpParams: Header parameters of request
    ///   - requestType: HTTP type request
    ///   - handler: Callback is called when url requst is finished
    func makeAndDoRequest<T: Codable>(_ urlString: String, _ httpParams: [String : String]? = nil, _ requestType: RequestType, handler: @escaping CompletionHandler<T>) {
        if let request = builder.setParams(httpParams).setPath(urlString).setReuestType(requestType).build() {
            let task = session.dataTask(with: request, completionHandler: responseHandler(with: handler))
            task.resume()
        }
        else {
            handler(false, nil, NetworkDomainErrors.somethingGoesWrong)
        }
    }
    
    private func responseHandler<T: Codable>(with handler:@escaping CompletionHandler<T>) -> (Data?, URLResponse?, Error?) -> Swift.Void {
        
        return { (data, response, error) in
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                if let error = error {
                    DispatchQueue.main.async {
                        handler(false, nil, ("Network Error.", error.localizedDescription))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        handler(false, nil, NetworkDomainErrors.somethingGoesWrong)
                    }
                }
                return
            }
            
            switch response.statusCode {
            case 200...204:
                if let dataResponse = data {
                    do {
                        let mappableObject = try JSONDecoder().decode([T].self, from: dataResponse)
                        DispatchQueue.main.async {
                            handler(true, mappableObject, nil)
                        }
                    } catch {
                        handler(false, nil, nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        handler(true, nil, nil)
                    }
                }
            default:
                DispatchQueue.main.async {
                    if let error = error {
                        handler(false, nil, ("Server Error.", error.localizedDescription))
                    }
                    else {
                        handler(false, nil, ("Status Code "+String(response.statusCode), HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))
                    }
                }
                
            }
            
        }
        
    }
    
}
