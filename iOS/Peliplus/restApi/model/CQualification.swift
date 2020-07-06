//
//  CQualification.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

struct CQualification : Codable {
    let movieId: String!
    let userId: String!
    let name: String!
    let avatar: String!
    let qualification: String!
    let movieQualificationId: String!
}

extension CQualification {
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case userId = "user_id"
        case name = "name"
        case avatar = "avatar"
        case qualification = "qualification"
        case movieQualificationId = "movie_qualification_id"
    }
}



