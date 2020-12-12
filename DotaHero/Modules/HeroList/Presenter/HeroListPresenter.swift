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
}
