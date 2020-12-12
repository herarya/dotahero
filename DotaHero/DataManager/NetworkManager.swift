//
//  NetworkManager.swift
//  DotaHero
//
//  Created by herman on 12/12/20.
//  Copyright © 2020 dota. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager{
    public class var API: NetworkManager {
        return NetworkManager()
    }

    func request(url: String, completion: ((Data?, Error?) -> Void)?) {
       AF.request(url).validate().responseData { response in
           switch response.result {
           case let .success(data):
             print(data)
           case let .failure(error):
            print(error)
           }
       }
    }
}
