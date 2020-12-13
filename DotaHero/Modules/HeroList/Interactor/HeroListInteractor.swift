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
    func didRetrieveRoles(roleData roles: [RoleModel])
}


protocol HeroListInteractorInputProtocol: class {
    func getDataHeroes()
    func getHeroesWithFilter(role:String)
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
        
        let roles = self.localDbManager.fetchRoles()
        let heroes = self.localDbManager.fetchHeroes()
        print(roles?.count)
        guard heroes?.isEmpty == true else {
            interactorOutput?.didRetrieveHeroes(heroData: heroes!)
            interactorOutput?.didRetrieveRoles(roleData:roles!)
            return
        }
        service.fetchHeroes(onSuccess: { data in
            guard let data = data else { return }
            self.localDbManager.store(data: data)
            let heroes = self.localDbManager.fetchHeroes()
            let roles = self.localDbManager.fetchRoles()
            self.interactorOutput?.didRetrieveHeroes(heroData: heroes!)
            self.interactorOutput?.didRetrieveRoles(roleData:roles!)
        }, onError: { error in
            print(error)
        })
    }
    
    func getHeroesWithFilter(role:String){
        var heroes = self.localDbManager.fetchHeroes()
        if role != "All" {
            heroes = heroes!.filter({ $0.roles.contains(role) })
        }
        interactorOutput?.didRetrieveHeroes(heroData: heroes!)
    }
}

