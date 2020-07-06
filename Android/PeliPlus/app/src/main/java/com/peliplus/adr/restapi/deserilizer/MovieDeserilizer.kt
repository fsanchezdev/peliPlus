package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.peliplus.adr.model.Movie
import java.lang.reflect.Type

class MovieDeserilizer : JsonDeserializer<Movie> {
    val TAG = "MovieDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): Movie {


        var jsonObject = json.asJsonObject

        // construir nuestra respuesta
        // devuelve una pelicula-movie

        val movie = Movie()

        movie.movie_id = jsonObject.get("movie_id").asInt
        movie.name = jsonObject.get("name").asString
        movie.year = jsonObject.get("year").asInt
        movie.description = jsonObject.get("description").asString
        movie.image = jsonObject.get("image").asString
        movie.type_movie_id = jsonObject.get("type_movie_id").asInt
        movie.type_movie = jsonObject.get("type_movie").asString

        // is null favorite in jason (exists)? that favorite is´t null?
        if (jsonObject.get("favorite") != null && !jsonObject.get("favorite").isJsonNull){
            movie.favorite = FavoriteDeserilizer.myDeserialize(jsonObject.get("favorite").asJsonObject)
        }

        movie.average = QualificationDeserilizer.average(jsonObject.get("average").asJsonObject)

        //is qualified?
        if (jsonObject.get("qualification") != null && !jsonObject.get("qualification").isJsonNull)
            movie.qualification = QualificationDeserilizer.myDeserialize(jsonObject.get("qualification").asJsonObject)

        movie.qualifications =
            QualificationsDeserilizer.myDeserialize(jsonObject.get("qualifications").asJsonArray).qualifications

        return movie


    }

}