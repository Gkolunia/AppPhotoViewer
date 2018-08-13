//
//  PhotoItemViewModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import CoreGraphics

struct PhotoItemViewModel {
    
    let smallImageUrl : URL
    let largeImageUrl : URL
    let size : CGSize
    let likes : Int
    
    init(from model: PhotoItemModel) {
        smallImageUrl = model.urls.small
        largeImageUrl = model.urls.full
        size = CGSize(width: model.width, height: model.height)
        likes = model.likes
    }
    
}
