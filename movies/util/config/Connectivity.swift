//
//  Connectivity.swift
//  movies
//
//  Created by Fernando Zaldivar on 9/3/22.
//

import Foundation
import Alamofire

final class Connectivity {

    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
