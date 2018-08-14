//
//  PhotoItemViewModel.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import CoreGraphics

protocol EquatableItem : Equatable {
    var id : String { get set }
}

func ==<T: EquatableItem>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}

struct PhotoItemViewModel : EquatableItem {

    let smallImageUrl : URL
    let largeImageUrl : URL
    let size : CGSize
    let likes : Int
    let tagTitle : String
    var id: String
    
    init(from model: PhotoItemModel) {
        smallImageUrl = model.urls.small
        largeImageUrl = model.urls.full
        size = CGSize(width: model.width, height: model.height)
        likes = model.likes
        tagTitle = model.tags.first?.title ?? ""
        id = model.id
    }

}
