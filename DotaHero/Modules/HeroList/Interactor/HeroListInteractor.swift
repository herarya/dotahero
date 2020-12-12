//
//  HeroListInteractor.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation


protocol HeroListInteractorInputProtocol: class {
    func getDataHeroes()
}

class HeroListInteractor:HeroListInteractorInputProtocol{
    private var localDbManager: LocalDataManager
    private var service: HeroesService
    
    
    init(localDbManager: LocalDataManager, service:HeroesService) {
        self.service = service
        self.localDbManager = localDbManager
    }
    
    func getDataHeroes(){
        
        service.fetchHeroes(onSuccess: { data in
            guard let data = data else { return }
            self.localDbManager.store(data: data)
        }, onError: { error in
            print(error)
        })
    }
}

