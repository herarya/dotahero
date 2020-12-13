//
//  HomeViewController.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController{

    
    var presenter : HeroListPresenterProtocol?
    
    @IBOutlet weak var heroRoleCollectionView: UICollectionView!
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    var heroesList: [HeroModel] = []
    var rolesList: [RoleModel] = []

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

extension HeroListViewController: HeroViewListProtocol {
    func showRoles(with roles: [RoleModel]) {
        rolesList = roles
        heroRoleCollectionView.reloadData()
    }
    
    func showHeroes(with heroes: [HeroModel]) {
        heroesList = heroes
        heroCollectionView.reloadData()
    }
}


extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.heroRoleCollectionView {
            return rolesList.count
        }
        return heroesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.heroRoleCollectionView {
            let heroRoleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroRoleCollectionViewCell", for: indexPath) as! HeroRoleCollectionViewCell
            let role = rolesList[indexPath.row]
            heroRoleCell.setupUI(forRole: role)
            return heroRoleCell
        }else{
            let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
            let hero = heroesList[indexPath.row]
            heroCell.setupUI(forHero: hero)
            return heroCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.heroRoleCollectionView {
            let role = rolesList[indexPath.row]
            return HeroRoleCollectionViewCell.cellSize(withLabel: role.name)
        }else if collectionView == self.heroCollectionView {
            return HeroCollectionViewCell.cellSize()
        }
        return .zero
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.heroRoleCollectionView {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if collectionView == self.heroRoleCollectionView {
        let role = rolesList[indexPath.row]
        presenter?.getHeroesWithFilter(role: role.name)
       }else {
        let hero = heroesList[indexPath.row]
        presenter?.showPostDetail(forHero: hero)
       }
    }
    
}
