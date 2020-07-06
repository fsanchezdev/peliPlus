package com.peliplus.adr.adapter

import android.app.Activity
import android.content.Intent
import android.support.v4.app.ActivityOptionsCompat
import android.support.v4.util.Pair
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.peliplus.adr.R
import com.peliplus.adr.activities.DetailMovieActivity
import com.peliplus.adr.model.Movie
import com.peliplus.adr.restapi.ResourcesURL
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.adapter_movie.view.*
                    //my constructor
class MovieAdapter(private val activity: Activity, private val movies: MutableList<Movie>) :
     //Inherited from that and has overwritten methods, this saves us from creating a separate class for only one use
    RecyclerView.Adapter<MovieAdapter.MyViewHolder>() {
    override fun onCreateViewHolder(p0: ViewGroup, p1: Int): MyViewHolder {
        return MyViewHolder(p0, activity)
    }

    override fun getItemCount(): Int {
        return movies.size
    }

    override fun onBindViewHolder(myViewHolder: MyViewHolder, index: Int) {
        myViewHolder.buildView(movies.get(index))
    }

    class MyViewHolder(parent: ViewGroup, private val activity: Activity) : RecyclerView.ViewHolder(
        LayoutInflater.from(parent.context).inflate(R.layout.adapter_movie, parent, false)
    ) {

        fun buildView(movie: Movie) = with(itemView) {

            Picasso.get()
                .load(ResourcesURL.URL_RESOURCE_IMAGE + movie.image)
                .error(R.mipmap.ic_launcher)
                .into(movieIV);

            containerCV.setOnClickListener {

                var intent = Intent(activity, DetailMovieActivity::class.java)
                intent.putExtra("movie_id", it.tag.toString().toInt())

                //shared element activity - Transition
                var p0: Pair<View,String> = Pair(movieTV as View, "movieTV")
                var p1: Pair<View,String> = Pair(movieIV as View, "movieIV")
                var option = ActivityOptionsCompat.makeSceneTransitionAnimation(activity,p0,p1)

                // iniciar actividad
                activity.startActivity(intent,option.toBundle())
            }

            containerCV.tag = movie.movie_id
            movieTV.text = movie.name
        }

    }
}

