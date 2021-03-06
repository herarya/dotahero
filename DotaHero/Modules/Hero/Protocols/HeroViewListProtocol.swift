//
//  HomeViewListProtocol.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroViewListProtocol: class {
   func showHeroes(with heroes: [HeroModel])
   func showRoles(with roles: [RoleModel])
   func showError(message:String)
   func showLoading()
   func hideLoading()
    
}


