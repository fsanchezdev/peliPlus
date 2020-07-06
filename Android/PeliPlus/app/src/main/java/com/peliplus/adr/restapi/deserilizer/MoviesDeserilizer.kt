package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.peliplus.adr.model.Movie
import com.peliplus.adr.restapi.model.MoviesReponse
import java.lang.reflect.Type

class MoviesDeserilizer : JsonDeserializer<MoviesReponse>{
    val TAG = "MoviesDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): MoviesReponse {
        Log.i(TAG,json.toString())

        var data = json.asJsonArray

        var moviesReponse = MoviesReponse()

        // construir nuestra respuesta
        // de una coleccion de JSON a un arrayLIST - moviesRespose

        for (jsonElement in data){
            val jsonObject = jsonElement.asJsonObject

            val movie = Movie()

            movie.movie_id = jsonObject.get("movie_id").asInt
            movie.name = jsonObject.get("name").asString
            movie.year = jsonObject.get("year").asInt
            movie.image = jsonObject.get("image").asString
            movie.type_movie_id = jsonObject.get("type_movie_id").asInt
            movie.type_movie = jsonObject.get("type_movie").asString

            moviesReponse.movies.add(movie)
        }

        return moviesReponse

    }

}