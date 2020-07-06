package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.peliplus.adr.model.Favorite
import java.lang.reflect.Type

class FavoriteDeserilizer : JsonDeserializer<Favorite> {
    val TAG = "FavoriteDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): Favorite {
        Log.i(TAG, json.toString())

        var jsonObject = json.asJsonObject

        // construir nuestra respuesta
        // devuelve una pelicula-movie
        return myDeserialize(jsonObject)
    }

    companion object {

        fun myDeserialize(jsonObject: JsonObject) : Favorite{
            val favorite = Favorite()

            favorite.movie_favorite_id = jsonObject.get("movie_favorite_id").asInt
            favorite.movie_id = jsonObject.get("movie_id").asInt
            favorite.user_id = jsonObject.get("user_id").asInt
            return favorite
        }

    }

}