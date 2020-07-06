//
//  CAverage.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

struct CAverage : Codable {
    let average: String!
}

extension CAverage {
    enum CodingKeys: String, CodingKey {
        case average = "average"
    }
}


