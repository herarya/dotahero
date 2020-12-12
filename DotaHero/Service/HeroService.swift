//
//  HeroService.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//


import Foundation
import Alamofire

public class HeroesService {
    
    func fetchHeroes() {
        NetworkManager.API.request(url: Endpoints.Heroes.fetchHeroes.url) { (data, error) in
            print(data)
        }
    }
}
