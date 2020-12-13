//
//  HeroRoleCollectionViewCell.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroRoleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return "HeroRoleCollectionViewCell"
    }
    
    static func cellSize(withLabel label: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 12)
        let width = label.size(withAttributes: [.font: font]).width + 35
        return CGSize(width: width, height: 40)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.masksToBounds = true
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
    
    func setupUI(forRole role: RoleModel) {
        nameLabel?.text = role.name
    }
    
}
