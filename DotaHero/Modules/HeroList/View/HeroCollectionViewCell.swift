//
//  HeroCollectionViewCell.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return "HeroCollectionViewCell"
    }
    
    static func cellSize() -> CGSize {
        let padding : CGFloat =  20
        let width =  UIScreen.main.bounds.width - padding
        return CGSize(width: width/2, height: 220)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
