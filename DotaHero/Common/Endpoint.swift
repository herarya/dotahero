//
//  Endpoint.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation

struct API {
    static let baseUrlApi = "https://api.opendota.com/api"
    static let baseUrlImage = "https://api.opendota.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Heroes: Endpoint {
        
        case fetchHeroes
        
        public var path: String {
            switch self {
                case .fetchHeroes: return "/herostats"
            }
        }
        
        public var url: String {
            switch self {
                case .fetchHeroes: return "\(API.baseUrlApi)\(path)"
            }
        }
    }
}
