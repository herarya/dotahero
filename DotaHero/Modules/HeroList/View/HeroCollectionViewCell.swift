//
//  HeroCollectionViewCell.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit
import AlamofireImage

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func cellReuseIdentifier() -> String {
        return "HeroCollectionViewCell"
    }
    
    static func cellSize() -> CGSize {
        let padding : CGFloat = 30
        let width =  UIScreen.main.bounds.width - padding
        return CGSize(width: width/2, height: 100)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
           super.prepareForReuse()
           nameLabel.text = ""
    }
    
    func setupUI(forHero hero: HeroModel) {
        nameLabel?.text = hero.localizedName
        let url = URL(string: API.baseUrlImage + hero.image)!
        let placeholderImage = UIImage(named: "placeholder")!
        heroImage.af.setImage(withURL: url, placeholderImage: placeholderImage)
    }
    
}
