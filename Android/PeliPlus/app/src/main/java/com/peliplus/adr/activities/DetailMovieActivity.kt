package com.peliplus.adr.activities

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.RatingBar
import com.peliplus.adr.R
import com.peliplus.adr.model.Movie
import com.peliplus.adr.model.Qualification
import com.peliplus.adr.restapi.ResourcesURL
import com.peliplus.adr.restapi.RestApiAdapter
import com.peliplus.adr.utils.UserPreferences
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_detail_movie.*
import retrofit2.Call
import retrofit2.Response

class DetailMovieActivity : AppCompatActivity() {


    var movie_id: Int = 0
    val TAG = "DetailMovieActivity"
    var favorite = 0

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detail_movie)

        val extras = intent.extras
        if (extras != null) {
            movie_id = extras.getInt("movie_id")
        }

        Log.i(TAG, "movie_id: $movie_id")

        if (UserPreferences.getId(this) == 0) {
            favoriteIV.visibility = View.GONE
            favoriteTV.visibility = View.GONE

            ratingBar.visibility = View.GONE
        }


            ratingBar.setOnRatingBarChangeListener { ratingBar: RatingBar, rating: Float, b: Boolean ->
                Log.e(TAG, rating.toString())
                _qualificationInsert(rating)
            }
        favoriteIV.setOnClickListener {
            _favorite()
        }

        _showMovie()

        shareIV.setOnClickListener {
            _share()
        }






    }


    private fun _share() {
        //Intent used for share
        var intent = Intent()
        intent.action = Intent.ACTION_SEND
        intent.putExtra(Intent.EXTRA_SUBJECT, movieTV.text.toString())
        intent.putExtra(Intent.EXTRA_TEXT, descriptionTV.text.toString())

        intent.type = "text/plain"
        startActivity(Intent.createChooser(intent, "Compartir"))

    }

    private fun _showMovie() {

        var user_id: Int? = null
        if (UserPreferences.getId(this) > 0) {
            user_id = UserPreferences.getId(this)
        }

        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerMovie()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.detailMovie(movie_id, user_id)

        call.enqueue(object : retrofit2.Callback<Movie> {

            override fun onResponse(call: Call<Movie>, response: Response<Movie>) {

                var movie = response.body()

                if (movie != null) {

                    collapsingToolbarLayout.title = movie.name
                    movieTV.text = movie.name
                    descriptionTV.text = movie.description
                    qualificationTV.text = getString(R.string.qualification) + ": ${movie.average}"

                    if (movie.favorite?.movie_favorite_id != null) {
                        favorite = 1
                        favoriteIV.setImageResource(R.drawable.ic_favorite_40dp)
                    }

                    if(movie.qualifications!= null){

                        _qualificationUserPerMovie()
                    }

                    Picasso.get()
                        .load(ResourcesURL.URL_RESOURCE_IMAGE + movie.image)
                        .error(R.mipmap.ic_launcher)
                        .into(movieIV);
                }
            }

            override fun onFailure(call: Call<Movie>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }

    private fun _favorite() {

        if (favorite == 0)
            favorite = 1
        else
            favorite = 0

        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerSimple()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.favorite(
            UserPreferences.getId(this),
            UserPreferences.getToken(this),
            movie_id,
            favorite)

        call.enqueue(object : retrofit2.Callback<String> {

            override fun onResponse(call: Call<String>, response: Response<String>) {

                var res = response.body()

                if (res == "ok") {
                    if (favorite == 0) {
                        favoriteIV.setImageResource(R.drawable.ic_favorite_border_40dp)
                    } else {
                        favoriteIV.setImageResource(R.drawable.ic_favorite_40dp)
                    }
                }

            }

            override fun onFailure(call: Call<String>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }

    /**
     * Asign the star rating
     */
    private fun _qualificationInsert(qualification:Float) {



        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerSimple()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.qualification(
            UserPreferences.getId(this),
            UserPreferences.getToken(this),
            movie_id,
            qualification)

        call.enqueue(object : retrofit2.Callback<String> {

            override fun onResponse(call: Call<String>, response: Response<String>) {

                var res = response.body()

                if (res == "ok") {

                }

            }

            override fun onFailure(call: Call<String>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }



    /**
     * Asign the star rating
     */
    private fun _qualificationUserPerMovie() {



        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerSimple()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.QualificationUserInMovie(
            UserPreferences.getId(this),
            movie_id)

        call.enqueue(object : retrofit2.Callback<Qualification> {

            override fun onResponse(call: Call<Qualification>, response: Response<Qualification>) {

                var res = response.body()

                if (res != null) {
                    ratingBar.rating= res.qualification!!
                }

            }

            override fun onFailure(call: Call<Qualification>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }

}