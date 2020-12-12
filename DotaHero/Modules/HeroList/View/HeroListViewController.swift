//
//  HomeViewController.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController, HeroViewListProtocol{

    
    var presenter : HeroListPresenterProtocol?
    
    @IBOutlet weak var heroRoleCollectionView: UICollectionView!
    @IBOutlet weak var heroCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupRoleCollection()
        setupHeroCollection()

    }
    
    func setupRoleCollection(){
        heroRoleCollectionView.delegate = self
        heroRoleCollectionView.dataSource = self
        heroRoleCollectionView.register(HeroRoleCollectionViewCell.nib(), forCellWithReuseIdentifier: HeroRoleCollectionViewCell.cellReuseIdentifier())
    }
    
    func setupHeroCollection(){
        heroCollectionView.delegate = self
        heroCollectionView.dataSource = self
        heroCollectionView.register(HeroCollectionViewCell.nib(), forCellWithReuseIdentifier: HeroCollectionViewCell.cellReuseIdentifier())
    }
    
}


extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.heroRoleCollectionView {
            let heroRoleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroRoleCollectionViewCell", for: indexPath) as! HeroRoleCollectionViewCell
            return heroRoleCell
        }else{
            let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
            return heroCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.heroRoleCollectionView {
           return HeroRoleCollectionViewCell.cellSize(withLabel: "test")
        }else if collectionView == self.heroCollectionView {
            return HeroCollectionViewCell.cellSize()
        }
        return .zero
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}
