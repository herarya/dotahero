//
//  HeroDetailViewController.swift
//  DotaHero
//
//  Created by herman on 13/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController{
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    @IBOutlet weak var baseHealth: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!
    @IBOutlet weak var primaryAttrLabel: UILabel!
    @IBOutlet weak var baseArmorLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    var presenter: HeroDetailPresenterProtocol?
    var hero: HeroModel?
    var similiarHeroes: [HeroModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupHeroCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    
    func setupHeroCollection(){
        heroCollectionView.delegate = self
        heroCollectionView.dataSource = self
        heroCollectionView.register(HeroCollectionViewCell.nib(), forCellWithReuseIdentifier: HeroCollectionViewCell.cellReuseIdentifier())
    }
    
    
}


extension HeroDetailViewController: HeroDetailViewProtocol {
    func showSimiliarHeroes(heroes: [HeroModel]) {
        self.similiarHeroes = heroes
        heroCollectionView.reloadData()
    }
    
    func showHeroDetail(forHero hero: HeroModel) {
        self.title = hero.localizedName
        let url = URL(string: API.baseUrlImage + hero.image)!
        let placeholderImage = UIImage(named: "placeholder")!
        postImageView.af.setImage(withURL: url, placeholderImage: placeholderImage)
        
        baseHealth.text = "\(hero.baseHealth)"
        attackLabel.text = "\(hero.maxAttack)"
        moveSpeedLabel.text = "\(hero.moveSpeed)"
        primaryAttrLabel.text = hero.primaryAttr
        baseArmorLabel.text = "\(hero.baseAarmor)"
        
        rolesLabel.text = "Role : \(hero.roles.joined(separator: ","))"
    }
}

extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similiarHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        let hero = similiarHeroes[indexPath.row]
        heroCell.setupUI(forHero: hero)
        return heroCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HeroCollectionViewCell.cellDetailSize()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
        
}
