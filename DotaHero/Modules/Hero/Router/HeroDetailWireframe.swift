//
//  HeroDetailWireframe.swift
//  DotaHero
//
//  Created by herman on 13/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import UIKit

protocol HeroDetailWireframeProtocol: class {
    static func createModuleDetail(forHero hero: HeroModel) -> UIViewController
}

class HeroDetailWireframe: HeroDetailWireframeProtocol{
    
    // MARK: - Methods
    
    class func createModuleDetail(forHero hero: HeroModel) -> UIViewController {
        guard let localDbManager = (UIApplication.shared.delegate as? AppDelegate)?.localDataManager else { fatalError("error get db") }
        let view = HeroDetailViewController()
      
        let wireFrame: HeroDetailWireframeProtocol = HeroDetailWireframe()
        let interactor = HeroDetailInteractor(localDbManager: localDbManager)
        let presenter = HeroDetailPresenter(interactor: interactor, view: view, wireFrame: wireFrame)
        view.presenter = presenter
        presenter.view = view
        interactor.interactorOutput = presenter
        presenter.hero = hero
        return view
    }
}

