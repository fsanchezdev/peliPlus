//
//  CFavorite.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

struct CFavorite : Codable {
    let movieId: String!
    let userId: String!
    let movieFavoriteId: String!
}

extension CFavorite {
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case userId = "user_id"
        case movieFavoriteId = "movie_favorite_id"
    }
}
