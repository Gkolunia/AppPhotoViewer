//
//  ImageView.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/13/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief ImageView provides downloading image from given URL.
 */
class ImageView : UIImageView {
    
    /**
     * @brief Current downloading. Can be canceled for example from table view cell. When cell is reused but previous loading is not finished.
     */
    private var urlTask : URLSessionDataTask?
    
    public func loadImageFromURL(url: URL) {
        
        let request = URLRequest(url: url)
        
        urlTask = URLSession.shared.dataTask(with: request) { [unowned self] (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }
        urlTask?.resume()
        
    }
    
    public func cancelLoading() {
        if let task = urlTask {
            task.cancel()
            urlTask = nil
        }
    }
    
}
