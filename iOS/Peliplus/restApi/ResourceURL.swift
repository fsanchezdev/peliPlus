//
//  ResourceURL.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation


struct ResourceURL{
    static let URL_BASE="http://192.168.87.1/peliplus/"
    static let URL_IMG_BASE = URL_BASE+"uploads/movies/"
    
    // *** usuarios
    static let URL_POST_USER_LOGIN = URL_BASE + "api/users/login"
    static let URL_POST_USER_SIGN_UP = URL_BASE + "api/users/sign_up"
    static let URL_GET_USER_IS_LOGIN = URL_BASE + "api/users/is_login/"
    static let URL_POST_USER_AVATAR = URL_BASE + "api/users/upload_avatar/"
    static let URL_GET_USER_AVATAR_RESOURCE = URL_BASE + "uploads/avatar/"
    
    // *** social
    static let URL_POST_FAVORITE = URL_BASE+"api/movies/favorite"
    static let URL_POST_QUALIFICATION = URL_BASE+"api/movies/qualification"
    
    
    // *** peliculas
    static let URL_SHOW_ALL_MOVIES = URL_BASE+"api/movies/show"
    static let URL_SHOW_ALL_TYPES_MOVIE = URL_BASE+"api/movies/types_movie"
    static let URL_SHOW_MOVIE = URL_BASE+"api/movies/show/"
    
}
