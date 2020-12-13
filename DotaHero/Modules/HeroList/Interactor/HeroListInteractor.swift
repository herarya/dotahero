//
//  HeroListInteractor.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroListInteractorOutputProtocol: class {
    func didRetrieveHeroes(heroData heroes: [HeroModel])
}


protocol HeroListInteractorInputProtocol: class {
    func getDataHeroes()
}


class HeroListInteractor:HeroListInteractorInputProtocol{
    private var localDbManager: LocalDataManager
    private var service: HeroesService
    weak var interactorOutput: HeroListInteractorOutputProtocol?
    
    
    init(localDbManager: LocalDataManager, service:HeroesService) {
        self.service = service
        self.localDbManager = localDbManager
    }
    
    func getDataHeroes(){
       
        let heroes = self.localDbManager.fetchHeroes()
        guard heroes?.isEmpty == true else {
            interactorOutput?.didRetrieveHeroes(heroData: heroes!)
            return
        }
        service.fetchHeroes(onSuccess: { data in
            guard let data = data else { return }
            self.localDbManager.store(data: data)
            let heroes = self.localDbManager.fetchHeroes()
            self.interactorOutput?.didRetrieveHeroes(heroData: heroes!)
        }, onError: { error in
            print(error)
        })
    }
}

