//
//  HeroDetailInteractor.swift
//  DotaHero
//
//  Created by herman on 14/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroDetailInteractorOutputProtocol: class {
    func didRetrieveSimiliarHeroes(heroData heroes: [HeroModel])
}

protocol HeroDetailInteractorInputProtocol: class {
   func getHeroesSimiliar(atr:String)
}


class HeroDetailInteractor: HeroDetailInteractorInputProtocol{
    
    private var localDbManager: LocalDataManager
    weak var interactorOutput: HeroDetailInteractorOutputProtocol?
    
    
    init(localDbManager: LocalDataManager) {
        self.localDbManager = localDbManager
    }
    
    func getHeroesSimiliar(atr: String) {
        guard let heroes = self.localDbManager.fetchHeroes() else { return }
        var similiarHeroes = [HeroModel]()
        if atr == "agi"{
            similiarHeroes = heroes.sorted(by: { $0.moveSpeed > $1.moveSpeed })
        }else if atr == "str" {
            similiarHeroes = heroes.sorted(by: { $0.maxAttack > $1.maxAttack })
        } else {
            similiarHeroes = heroes.sorted(by: { $0.baseAarmor > $1.baseAarmor })
        }
        interactorOutput?.didRetrieveSimiliarHeroes(heroData: Array(similiarHeroes.prefix(3)))
    }
}

