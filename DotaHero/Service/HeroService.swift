//
//  HeroService.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//


import Foundation
import Alamofire

public typealias onSuccessCallBack = (Data?) -> Void
public typealias onErrorCallBack = (Error?) -> Void

public class HeroesService {
    
    func fetchHeroes(onSuccess : onSuccessCallBack?, onError : onErrorCallBack) {
        NetworkManager.API.request(url: Endpoints.Heroes.fetchHeroes.url) { (data, error) in
            guard let data = data else { return }
            onSuccess?(data)
        }
    }
}
