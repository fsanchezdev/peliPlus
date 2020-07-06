//
//  User.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 29/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

class User: NSObject {
    var userId: Int!
    var name: String!
    var email: String!
    var password: String!
    var token: String!
    
    init(name: String) {
        self.name = name
    }
    
    init(cUser: CUser) {
        self.userId = Int(cUser.userId)
        self.name = cUser.name
        self.email = cUser.email
        
        if cUser.token != nil {
            self.token = cUser.token
        } else {
            self.token = ""
        }
        
        if cUser.password != nil {
            self.password = cUser.password
        } else {
            self.password = ""
        }
    }
}
