//
//  PhotoItemViewModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import CoreGraphics

/// View model contains data is needed to setup collection view cells.
struct PhotoItemViewModel : Equatable {

    let smallImageUrl : URL
    let largeImageUrl : URL
    let size : CGSize
    let likes : Int
    let tagTitle : String
    let id: String
    
    /// Init for creating view models from photo model.
    ///
    /// - Parameter model: photo model is model which is created after parsing json.
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


