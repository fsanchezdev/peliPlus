package com.peliplus.adr.adapter

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView
import com.peliplus.adr.model.TypeMovie

//Our class take in the constructor the values from the ArrayAdapter
class TypeMoviesSpinnerAdapter(context: Context, resource: Int,val typesMovie: ArrayList<TypeMovie>) :
    ArrayAdapter<TypeMovie>(context, resource, typesMovie) {
    //Show the data of the array
    override fun getDropDownView(position: Int, convertView: View?, parent: ViewGroup): View {

        var textView=TextView(context)
        textView.text=typesMovie[position].name


        return textView
    }

    //Show the data instead the toString of the value
    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        var textView=TextView(context)
        textView.text=typesMovie[position].name


        return textView
    }
}