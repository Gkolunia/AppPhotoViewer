//
//  HelperProtocol.swift
//  AppPhotoViewer
//
//  Created by Mykola_Hrybeniuk on 8/26/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

protocol EventsHandling where View == ViewLoading & ViewDataReloading {
    associatedtype View
    func loadData(in view: View)
}

protocol ListDataProvider {
    associatedtype Element
    func count() -> Int
    func item(at index: Int) -> Element
}
