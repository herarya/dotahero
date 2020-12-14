//
//  HeroListPresenter.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import UIKit

protocol HeroListPresenterProtocol: class {
    // VIEW -> PRESENTER
    func viewDidLoad()
    func getHeroesWithFilter(role:String)
    func showPostDetail(forHero hero: HeroModel)
}



class HeroListPresenter: HeroListPresenterProtocol{
    
    var interactor: HeroListInteractorInputProtocol?
    weak var view: HeroViewListProtocol?
    var wireFrame: HomeWireframeProtocol?
    
    init(interactor: HeroListInteractorInputProtocol,view: HeroViewListProtocol, wireFrame: HomeWireframeProtocol) {
        self.interactor = interactor
        self.view = view
        self.wireFrame = wireFrame
    }
    
    func viewDidLoad() {
        view?.showLoading()
        self.interactor?.getDataHeroes()
    }
    
    func getHeroesWithFilter(role:String){
        self.interactor?.getHeroesWithFilter(role: role)
    }
    
    func showPostDetail(forHero hero: HeroModel) {
        self.wireFrame?.presentHeroDetailScreen(from: view!, forHero: hero)
    }
}


extension HeroListPresenter: HeroListInteractorOutputProtocol {
    func didRetrieveRoles(roleData roles: [RoleModel]) {
        view?.showRoles(with: roles)
    }
    
    func didRetrieveHeroes(heroData heroes: [HeroModel]) {
        view?.hideLoading()
        view?.showHeroes(with: heroes)
    }
    
    func showError(withMessage message: String) {
        view?.showError(message: message)
    }
    
}

