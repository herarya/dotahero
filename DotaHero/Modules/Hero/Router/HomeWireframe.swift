//
//  HomeWireframe.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import UIKit

protocol HomeWireframeProtocol: class {
    static func createModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentHeroDetailScreen(from view: HeroViewListProtocol, forHero hero: HeroModel)
}

class HomeWireframe: HomeWireframeProtocol{
    
    // MARK: - Methods
    
    class func createModule() -> UIViewController {
        guard let localDbManager = (UIApplication.shared.delegate as? AppDelegate)?.localDataManager else { fatalError("error get db") }
        let view = HeroListViewController()
        let service = HeroesService()
        let interactor = HeroListInteractor(localDbManager: localDbManager, service: service)
        let wireFrame: HomeWireframeProtocol = HomeWireframe()
        let presenter = HeroListPresenter(interactor: interactor, view: view, wireFrame: wireFrame)
        let navigation = UINavigationController(rootViewController: view)
        view.presenter = presenter
        presenter.view = view
        interactor.interactorOutput = presenter
        return navigation
    }
    
   func presentHeroDetailScreen(from view: HeroViewListProtocol, forHero hero: HeroModel) {
      
    let heroDetailViewController = HeroDetailWireframe.createModuleDetail(forHero: hero)
      if let sourceView = view as? UIViewController {
        sourceView.navigationController?.pushViewController(heroDetailViewController, animated: true)
      }
    }

}

