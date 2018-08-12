//
//  PhotosRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation


class PhotosRequestManager : APIRequestManager {
    
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotoItemModel>) {
        makeAndDoRequest("/photos", ["page" : String(pageNumber), "per_page" : String(countPerPage), "order_by" : "latest"], .get, handler: handler)
    }
    
}
