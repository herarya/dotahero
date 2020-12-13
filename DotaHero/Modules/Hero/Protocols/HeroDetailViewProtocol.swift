//
//  HeroDetailViewProtocol.swift
//  DotaHero
//
//  Created by herman on 13/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroDetailViewProtocol: class {
    func showHeroDetail(forHero hero: HeroModel)
    func showSimiliarHeroes(heroes: [HeroModel])
}

