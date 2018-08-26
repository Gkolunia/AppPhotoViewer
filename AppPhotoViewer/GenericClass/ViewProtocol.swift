//
//  ViewProtocols.swift
//  AppPhotoViewer
//
//  Created by Mykola_Hrybeniuk on 8/26/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Abstraction 
protocol ViewLoading: class {
    var isLoading: Bool { get set }
}

protocol ViewDataReloading: class {
    func reloadData()
}

protocol GenericReuseView: class {
    static func reuseIdentifier() -> String
    static func nib() -> UINib
}

extension GenericReuseView {
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}

extension UITableViewCell : GenericReuseView { }
extension UICollectionViewCell : GenericReuseView { }

extension UITableView {
    
    func dequeueReusableCell<CellType: GenericReuseView>(for indexPath: IndexPath) -> CellType {
        if let cell = self.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier(), for: indexPath) as? CellType {
            return cell
        }
        fatalError("Cell type \(CellType.self) for reuse identifier \(CellType.reuseIdentifier()) does not exist")
    }
    
}

extension UICollectionView {
    
    func dequeueReusableCell<CellType: GenericReuseView>(for indexPath: IndexPath) -> CellType {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier(), for: indexPath) as? CellType {
            return cell
        }
        fatalError("Cell type \(CellType.self) for reuse identifier \(CellType.reuseIdentifier()) does not exist")
    }
    
}
