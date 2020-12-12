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
    
    private var service: HeroesService
    
    init(service:HeroesService) {
        self.service = service
    }
    
    func getDataHeroes(){
        service.fetchHeroes()
    }
}

