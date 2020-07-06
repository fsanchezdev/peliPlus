package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.*
import com.peliplus.adr.model.Favorite
import com.peliplus.adr.model.TypeMovie
import com.peliplus.adr.restapi.model.QualificationsReponse
import com.peliplus.adr.restapi.model.TypesMovieReponse
import java.lang.reflect.Type

class TypeMovieDeserilizer : JsonDeserializer<TypesMovieReponse> {
    val TAG = "FavoriteDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): TypesMovieReponse {
        Log.i(TAG, json.toString())



        // construir nuestra respuesta
        return myDeserialize(json.asJsonArray)
    }

    companion object {

        fun myDeserialize(data: JsonArray) : TypesMovieReponse {
            var typesMovieReponse = TypesMovieReponse()

            for (jsonElement in data){

                var jsonObject=jsonElement.asJsonObject
                val typeMovie = TypeMovie()


                typeMovie.type_movie_id = jsonObject.get("type_movie_id").asInt
                typeMovie.name = jsonObject.get("name").asString

                typesMovieReponse.typesMovie.add(typeMovie)
            }

            return typesMovieReponse
        }

    }

}