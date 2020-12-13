//
//  HeroDetailPresenter.swift
//  DotaHero
//
//  Created by herman on 13/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

protocol HeroDetailPresenterProtocol: class {
    var hero: HeroModel? { get set }
    // VIEW -> PRESENTER
    func viewDidLoad()
}


class HeroDetailPresenter: HeroDetailPresenterProtocol {
    
    weak var view: HeroDetailViewProtocol?
    var wireFrame: HeroDetailWireframeProtocol?
    var interactor: HeroDetailInteractorInputProtocol?
    var hero: HeroModel?
    
    init(interactor: HeroDetailInteractorInputProtocol,view: HeroDetailViewProtocol, wireFrame: HeroDetailWireframeProtocol) {
        self.interactor = interactor
        self.view = view
        self.wireFrame = wireFrame
    }
    func viewDidLoad() {
        interactor?.getHeroesSimiliar(atr: hero!.primaryAttr)
        view?.showHeroDetail(forHero: hero!)

    }
    
}



extension HeroDetailPresenter: HeroDetailInteractorOutputProtocol {
    func didRetrieveSimiliarHeroes(heroData heroes: [HeroModel]) {
        view?.showSimiliarHeroes(heroes: heroes)
    }
    
}
