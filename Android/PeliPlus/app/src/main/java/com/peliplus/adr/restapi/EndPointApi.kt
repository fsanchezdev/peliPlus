package com.peliplus.adr.restapi

import com.peliplus.adr.model.Movie
import com.peliplus.adr.model.Qualification
import com.peliplus.adr.model.User
import com.peliplus.adr.restapi.model.MoviesReponse
import com.peliplus.adr.restapi.model.TypesMovieReponse
import okhttp3.MultipartBody
import retrofit2.Call
import retrofit2.http.*


interface EndPointApi {

    /*
    * Usuarios
    * */

    @FormUrlEncoded
    @POST(ResourcesURL.URL_POST_USER_LOGIN)
    fun login(
        @Field("email") email: String,
        @Field("password") password: String
    ): Call<User>

    @FormUrlEncoded
    @POST(ResourcesURL.URL_POST_USER_REGISTER)
    fun register(
        @Field("name") name: String,
        @Field("email") email: String,
        @Field("password") password: String,
        @Field("confirm_password") confirm_password: String
    ): Call<User>

    @GET(ResourcesURL.URL_GET_IS_LOGIN)
    fun isLogin(@Path("token") token: String): Call<String>

    @Multipart
    @POST(ResourcesURL.URL_POST_USER_UPLOAD_AVATAR)
    fun uploadAvatar(@Part image: MultipartBody.Part, @Path("user_id") user_id: Int): Call<String>



    /*
    * Peliculas
    * */
    @GET(ResourcesURL.URL_GET_SHOW_ALL_MOVIES)
    fun show(@Query("offset") offset: Int): Call<MoviesReponse>

    @GET(ResourcesURL.URL_GET_SHOW_ALL_MOVIES)
    fun search(
        @Query("name") name: String,
        @Query("year") year: String,
        @Query("offset") offset: Int
    ): Call<MoviesReponse>

    @GET(ResourcesURL.URL_GET_TYPES_MOVIE)
    fun typesMovie(): Call<TypesMovieReponse>

    @GET(ResourcesURL.URL_GET_SHOW_MOVIE)
    fun detailMovie(@Path("movie_id") movie_id: Int,
                    @Query("user_id") user_id: Int?): Call<Movie>

    @FormUrlEncoded
    @POST(ResourcesURL.URL_POST_FAVORITE)
    fun favorite(
        @Field("user_id") user_id: Int,
        @Field("token") token: String,
        @Field("movie_id") movie_id: Int,
        @Field("favorite") favorite: Int
    ): Call<String>

    @FormUrlEncoded
    @POST(ResourcesURL.URL_POST_QUALIFICATION)
    fun qualification(
        @Field("user_id") user_id: Int,
        @Field("token") token: String,
        @Field("movie_id") movie_id: Int,
        @Field("qualification") qualification: Float
    ): Call<String>

    @GET(ResourcesURL.URL_GET_QUALIFICATION)
    fun QualificationUserInMovie(@Query("user_id") movie_id: Int,
                    @Query("movie_id") user_id: Int?): Call<Qualification>


    /*
    * API
    * */

    @GET(ResourcesURL.URL_GET_IMAGE_PROMOTIONAL)
    fun imagePromotional(): Call<String>
}