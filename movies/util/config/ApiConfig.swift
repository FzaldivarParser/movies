//
//  ApiConfig.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

final class ApiConfig {

    static let shared = ApiConfig()
    let baseUrl: String
    let imageUrl: String
    let posterUrl: String
    let apiKey: String

    private init() {
        baseUrl = ApiConfig.readKey("Base url")
        imageUrl = ApiConfig.readKey("Image url")
        posterUrl = ApiConfig.readKey("Poster url")
        apiKey = ApiConfig.readKey("Api Key")
    }

    static func readKey(_ key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: key) as? String else {
            fatalError("Couldn't find key in 'Info.plist'.")
        }

        return value
    }
}
