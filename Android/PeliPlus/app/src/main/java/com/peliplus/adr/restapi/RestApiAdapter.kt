package com.peliplus.adr.restapi

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.peliplus.adr.model.Movie
import com.peliplus.adr.model.User
import com.peliplus.adr.restapi.deserilizer.*
import com.peliplus.adr.restapi.model.MoviesReponse
import com.peliplus.adr.restapi.model.TypesMovieReponse
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RestApiAdapter {
    fun conection(gson: Gson) :EndPointApi{
        val retrofit = Retrofit.Builder()
            .baseUrl(ResourcesURL.URL_BASE)
            .addConverterFactory(GsonConverterFactory.create(gson))
            .build()

        return retrofit.create(EndPointApi::class.java)
    }

    /*
    * Usuario
    * */

    fun gsonDeserizerUser(): Gson {
        val gsonBuilder = GsonBuilder().setLenient()
        gsonBuilder.registerTypeAdapter(User::class.java, UserDeserilizer())
        return  gsonBuilder.create()
    }

    /*
    * Peliculas
    * */

    fun gsonDeserizerMovies(): Gson {
        val gsonBuilder = GsonBuilder().setLenient()
        gsonBuilder.registerTypeAdapter(MoviesReponse::class.java, MoviesDeserilizer())
        return  gsonBuilder.create()
    }

    fun gsonDeserizerMovie(): Gson {
        val gsonBuilder = GsonBuilder().setLenient()
        gsonBuilder.registerTypeAdapter(Movie::class.java, MovieDeserilizer())
        return  gsonBuilder.create()
    }

    fun gsonDeserizerTypeMovie(): Gson {
        val gsonBuilder = GsonBuilder().setLenient()
        gsonBuilder.registerTypeAdapter(TypesMovieReponse::class.java, TypeMovieDeserilizer())
        return  gsonBuilder.create()
    }
    //String generic
    fun gsonDeserizerSimple(): Gson {
        val gsonBuilder = GsonBuilder().setLenient()
        gsonBuilder.registerTypeAdapter(String::class.java, SimpleDeserilizer())
        return  gsonBuilder.create()
    }

}