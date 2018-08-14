//
//  PhotoItemModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

struct PhotoUrls : Codable {
    let full : URL
    let small : URL
}

struct Tag : Codable {
    let title : String
}

struct PhotoItemModel : Codable {
    let id : String
    let urls : PhotoUrls
    let likes : Int
    let width : Int
    let height : Int
    let tags : [Tag]
}

struct PhotosContainer : Codable {
    let results : [PhotoItemModel]
}
