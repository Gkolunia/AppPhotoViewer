//
//  PhotoItemViewModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import CoreGraphics

struct PhotoItemViewModel : Equatable {
    
    let smallImageUrl : URL
    let largeImageUrl : URL
    let size : CGSize
    let likes : Int
    let tagTitle : String
    let id : String
    
    init(from model: PhotoItemModel) {
        smallImageUrl = model.urls.small
        largeImageUrl = model.urls.full
        size = CGSize(width: model.width, height: model.height)
        likes = model.likes
        tagTitle = model.tags.first?.title ?? ""
        id = model.id
    }
    
    static func ==(lhs: PhotoItemViewModel, rhs: PhotoItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
