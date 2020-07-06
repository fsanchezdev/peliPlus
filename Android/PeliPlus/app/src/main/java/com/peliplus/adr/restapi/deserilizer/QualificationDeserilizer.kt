package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.peliplus.adr.model.Qualification
import java.lang.reflect.Type


class QualificationDeserilizer : JsonDeserializer<Qualification> {
    val TAG = "QualifiDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): Qualification {
        Log.i(TAG, json.toString())

        var jsonObject = json.asJsonObject

        // construir nuestra respuesta
        // devuelve una pelicula-movie
        return myDeserialize(jsonObject)
    }

    companion object {

        fun myDeserialize(jsonObject: JsonObject): Qualification {
            val qualification = Qualification()

            qualification.movie_qualification_id = jsonObject.get("movie_qualification_id").asInt
            qualification.movie_id = jsonObject.get("movie_id").asInt
            qualification.user_id = jsonObject.get("user_id").asInt
            return qualification
        }

        fun average(jsonObject: JsonObject): Float {

            var average = 0.0F
            if (!jsonObject.get("average").isJsonNull)
                average = jsonObject.get("average").asFloat

            return average
        }

    }

}