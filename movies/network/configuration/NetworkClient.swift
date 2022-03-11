//
//  NetworkClient.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation
import Alamofire

class NetworkClient: PerformRequestProtocol {
    var configuration: ConfigurationProtocol

    init(configuration: ConfigurationProtocol = PolicyConfiguration(sessionManager: Session.default)) {
        self.configuration = configuration
    }
}
