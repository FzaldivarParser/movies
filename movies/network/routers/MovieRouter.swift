//
//  MovieRouter.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation
import Alamofire

enum MovieRouter: APIConfigurationProtocol {

    case popular(_ page: Int)
    case topRated(_ page: Int)
    case upcoming(_ page: Int)

    var httpMethod: HTTPMethod {
        return .get
    }

    var requestPath: String {
        switch self {
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        case .upcoming:
            return "/upcoming"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .popular(let page), .topRated(let page), .upcoming(let page):
            return [URLQueryItem(name: "page", value: page.description)]
        }
    }

    var parameters: Parameters? {
        return nil
    }
}
