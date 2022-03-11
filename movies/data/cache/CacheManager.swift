//
//  CacheManager.swift
//  movies
//
//  Created by Fernando Zaldivar on 10/3/22.
//

import Foundation

final class CacheManager {

    static let shared = CacheManager()

    private init() { }

    func save<T: Codable>(key: String, data: [T]) {
        do {
            let userDefaults = UserDefaults.standard
            let encodedDdata = try JSONEncoder().encode(data)
            userDefaults.set(encodedDdata, forKey: key)
            userDefaults.synchronize()
        } catch {
            print("Unable to Encode Array")
        }
    }

    func fetch<T: Codable>(key: String, type: T.Type) -> [T]? {
        let userDefaults = UserDefaults.standard

        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }

        let decoder = JSONDecoder()
        return (try? decoder.decode([T].self, from: data))
    }
}
