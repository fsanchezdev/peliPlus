package com.peliplus.adr.restapi.deserilizer

import android.util.Log
import com.google.gson.JsonArray
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.peliplus.adr.restapi.model.QualificationsReponse
import java.lang.reflect.Type

class QualificationsDeserilizer : JsonDeserializer<QualificationsReponse> {
    val TAG = "QualifsDeserilizer"
    override fun deserialize(json: JsonElement, typeOfT: Type?, context: JsonDeserializationContext?): QualificationsReponse {
        Log.i(TAG,json.toString())
        // construir nuestra respuesta
        // de una coleccion de JSON a un arrayLIST - moviesRespose
        return myDeserialize( json.asJsonArray)
    }

    companion object {

        fun myDeserialize(data: JsonArray) : QualificationsReponse{
            var qualificationsReponse = QualificationsReponse()

            for (jsonElement in data){
                val qualification = QualificationDeserilizer.myDeserialize(jsonElement.asJsonObject)
                qualificationsReponse.qualifications.add(qualification)
            }

            return qualificationsReponse
        }

    }

}