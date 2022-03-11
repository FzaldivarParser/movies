//
//  ConfigurationProtocol.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation
import Alamofire

protocol ConfigurationProtocol {
    func request<T: Decodable>(_ convertible: APIConfigurationProtocol, responseJSON completionHandler: @escaping (AFDataResponse<T>) -> Void)
}

class PolicyConfiguration: ConfigurationProtocol {

    let sessionManager: Session

    init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }

    func request<T: Decodable>(_ convertible: APIConfigurationProtocol, responseJSON completionHandler: @escaping (AFDataResponse<T>) -> Void) {
        sessionManager.request(convertible).validate(statusCode: 200..<305).responseDecodable(completionHandler: completionHandler)
    }
}
