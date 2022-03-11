//
//  Movie.swift
//  movies
//
//  Created by Fernando Zaldivar on 8/3/22.
//

import Foundation

struct Movie: Codable {

    let title: String
    let poster: String
    let backdrop: String?
    let overview: String
    let rate: Double

    private enum CodingKeys: String, CodingKey {
        case title
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case overview
        case rate = "vote_average"
    }
}
