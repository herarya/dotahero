//
//  HeroRoleCollectionViewCell.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroRoleCollectionViewCell: UICollectionViewCell {
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return "HeroRoleCollectionViewCell"
    }
    
    static func cellSize(withLabel label: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 12)
        let width = label.size(withAttributes: [.font: font]).width + 20
        return CGSize(width: width, height: 40)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
