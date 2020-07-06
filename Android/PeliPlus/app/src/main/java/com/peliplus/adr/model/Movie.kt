package com.peliplus.adr.model

class Movie {
    var movie_id: Int = 0
    var name: String = ""
    var year: Int = 0
    var description: String = ""
    var image: String = ""
    var type_movie_id: Int = 0
    var type_movie: String = ""
    var favorite : Favorite? = null
    var average : Float = 0.0F //No precisión needed
    var qualification : Qualification? = null
    var favorites = ArrayList<Favorite>()
    var qualifications = ArrayList<Qualification>()
}