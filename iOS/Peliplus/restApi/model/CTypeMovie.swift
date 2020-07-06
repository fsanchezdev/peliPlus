//
//  CTypeMovie.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation


struct CTypeMovie : Codable {
    let typeMovieId: String!
    let name: String!
}

extension CTypeMovie {
    enum CodingKeys: String, CodingKey {
        case typeMovieId = "type_movie_id"
        case name = "name"
    }
}
