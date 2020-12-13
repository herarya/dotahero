//
//  HeroListPresenter.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroListPresenterProtocol: class {
    // VIEW -> PRESENTER
    func viewDidLoad()
    func getHeroesWithFilter(role:String)
}



class HeroListPresenter: HeroListPresenterProtocol{
    
    var interactor: HeroListInteractorInputProtocol?
    weak var view: HeroViewListProtocol?
    
    init(interactor: HeroListInteractorInputProtocol,view: HeroViewListProtocol) {
        self.interactor = interactor
        self.view = view
    }
    
    func viewDidLoad() {
        self.interactor?.getDataHeroes()
    }
    
    func getHeroesWithFilter(role:String){
        self.interactor?.getHeroesWithFilter(role: role)
    }
}


extension HeroListPresenter: HeroListInteractorOutputProtocol {
    func didRetrieveRoles(roleData roles: [RoleModel]) {
        view?.showRoles(with: roles)
    }
    
    func didRetrieveHeroes(heroData heroes: [HeroModel]) {
        view?.showHeroes(with: heroes)
    }
    
}

