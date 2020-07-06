//
//  Movie.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 29/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation
import UIKit

public class Movie:NSObject {
    var movieId:Int!
    var name:String!  //implicity unwrapped optional, he is not going to check if null
    var image:String!
    var years:Int!
    var descrip:String!
    //var image:UIImage!
    var typeMovie:String!
    var typeMovieId:Int!
    
    init(name:String) {
        self.name=name
       	
    }
    
    init(cMovie:CMovie) {
        self.movieId = Int(cMovie.movieId)
        self.name=cMovie.name
        self.image=cMovie.image
        self.years=Int(cMovie.year)
        self.descrip=cMovie.descrip
        self.typeMovie=cMovie.typeMovie
        self.typeMovieId=Int(cMovie.typeMovieId)
        //self.image=#imageLiteral(resourceName: "avengers-inifity-war")
    }
    
    static func cMoviesToMovies(cMovies:[CMovie])->[Movie]{
        var movies:[Movie]=[]
        
        for cMovie in cMovies{
            
            movies.append(Movie(cMovie:cMovie))
        }
        
        return movies
    }
    
}
