//
//  FactItemCollectionViewCell.swift
//  Facts
//
//  Created by Hanuman on 21/06/18.
//  Copyright © 2018 Hanuman. All rights reserved.
//

import Foundation
import UIKit

protocol IdentifiableProtocol {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension IdentifiableProtocol where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}


class FactItemCollectionViewCell: UICollectionViewCell, IdentifiableProtocol {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    
}
