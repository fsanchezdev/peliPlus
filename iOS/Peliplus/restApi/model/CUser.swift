//
//  CUser.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

struct CUser : Codable {
    let userId: String!
    let name: String!
    let email: String!
    let password: String?
    let token: String?
}

extension CUser {
    enum CodingKeys: String, CodingKey {
          case userId = "user_id"
          case name = "name"
          case email = "email"
          case password = "password"
          case token = "token"
    }
}
