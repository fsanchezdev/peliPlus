//
//  CMovie.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation

struct CMovie:Codable{
    let movieId:String!
    let name:String!
    let image:String!
    let year:String!
    let descrip:String?
    let typeMovie:String!
    let typeMovieId:String!
    let favorite: CFavorite?
    let favorites: [CFavorite]?
    let qualification: CQualification?
    let qualifications: [CQualification]?
    let average: CAverage?

}
//for having custom names
extension CMovie{
    enum CodingKeys:String,CodingKey{
        case movieId="movie_id"
        case name="name"
        case image="image"
        case year="year"
        case descrip="description"
        case typeMovie="type_movie"
        case typeMovieId="type_movie_id"
        case favorite = "favorite"
        case favorites = "favorites"
        case qualification = "qualification"
        case qualifications = "qualifications"
        case average = "average"
    }
    
}








