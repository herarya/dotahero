//
//  HomeWireframe.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import UIKit

protocol  HomeWireframeProtocol: class {
    static func createModule() -> UIViewController
}

class HomeWireframe: HomeWireframeProtocol{
    
    // MARK: - Methods
    
    class func createModule() -> UIViewController {
        let view = HeroListViewController()
        let service = HeroesService()
        let interactor = HeroListInteractor(service: service)
        let presenter = HeroListPresenter(interactor: interactor, view: view)
        let navigation = UINavigationController(rootViewController: view)
        view.presenter = presenter
        presenter.view = view
        return navigation
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
