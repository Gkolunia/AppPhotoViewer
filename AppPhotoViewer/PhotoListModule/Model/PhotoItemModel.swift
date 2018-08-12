//
//  PhotoItemModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

struct PhotoUrls : Codable {
    let full : String
    let thumb : String
}

struct PhotoItemModel : Codable {
    
    let urls : PhotoUrls
    let likes : Int
    
}
