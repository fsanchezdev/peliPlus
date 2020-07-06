package com.peliplus.adr.activities.user

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.MediaStore
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Toast
import com.peliplus.adr.MainActivity
import com.peliplus.adr.R
import com.peliplus.adr.restapi.ResourcesURL
import com.peliplus.adr.restapi.RestApiAdapter
import com.peliplus.adr.utils.UserPreferences
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.user_activity.*
import okhttp3.MediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.Call
import retrofit2.Response
import java.io.File
import java.lang.Exception


class UserActivity : AppCompatActivity() {
    val TAG = "UserActivity"
    val REQUEST_ID_READ_EXTERNAL_STORAGE = 100
    val REQUEST_ACTION_PICK = 101

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.user_activity)

        Picasso.get()
            .load(ResourcesURL.URL_RESOURCE_AVATAR + UserPreferences.getAvatar(this))
            .error(R.drawable.logo)
            .into(avatarIV);

        closeSessionIV.setOnClickListener {
            UserPreferences.closeSession(this)
            Toast.makeText(this,"Cerrado de sesión exitoso",Toast.LENGTH_LONG).show()

            var intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }


        avatarIV.setOnClickListener {
            request_permission_control();
        }

        emailET.setText(UserPreferences.getEmail(this))
        nameET.setText(UserPreferences.getName(this))

    }


    fun request_permission_control(){
        //Contains useful functions about our context
        if(ContextCompat.checkSelfPermission(this, android.Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED){
            //This provokes the execution of a modal asking for permisions, after that the onRequestPermissionsResult is automatically called
            ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE),REQUEST_ID_READ_EXTERNAL_STORAGE)
        } else {
//            Log.e(TAG, "Permiso dado")
            // Show gallery
            //we need to show gallery too  in the function that is automatically called (onRequestPermissionsResult)
            selectImageGallery()
        }
    }

    fun selectImageGallery(){
                            //You can use intent to send data to other apps
        val galleryIntent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
        //This provokes the execution of  onActivityResult()
        startActivityForResult(galleryIntent, REQUEST_ACTION_PICK)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
                                                    //when both are -1 is ok
        if(requestCode == REQUEST_ACTION_PICK && resultCode == Activity.RESULT_OK){
            if(data != null){

                val uri = data.data
//                Log.e(TAG+" URI",uri.toString())

                val media = arrayOf(MediaStore.Images.Media.DATA)
//                Log.e(TAG+" media",media[0])
                //https://developer.android.com/guide/topics/providers/content-provider-basics.html#kotlin
                var cursor = getContentResolver().query(uri,media,null,null,null)   //contentResolver
                cursor.moveToFirst()
                val columnIndex = cursor.getColumnIndex(media[0])
                var path = cursor.getString(columnIndex)
                Log.e(TAG+" path",path)
                cursor.close()

                var file: File

                try {
                    file = File(path)
                    Log.e(TAG,file.name)

                    uploadAvatarToServer(file)
                }catch (e: Exception) {
 //                   Log.e(TAG, e.toString())
                }
            }
        }


    }

    fun uploadAvatarToServer(file: File){

        val reqFile = RequestBody.create(MediaType.parse("image/*"),file)
                                                        //Field that we are uploading ( name in endpoint),name, data from multiplart body
        val body = MultipartBody.Part.createFormData("image",file.name, reqFile)

        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerSimple()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.uploadAvatar(body, UserPreferences.getId(this))

        call.enqueue(object : retrofit2.Callback<String> {

            override fun onResponse(call: Call<String>, response: Response<String>) {

                var imageName = response.body()

                if (imageName != null) {

                    Log.e(TAG+" res",imageName)
                    Log.e(TAG+" res", ResourcesURL.URL_RESOURCE_AVATAR + imageName)

                    UserPreferences.setAvatar(this@UserActivity,imageName)

                    Picasso.get()
                        .load(ResourcesURL.URL_RESOURCE_AVATAR + imageName)
                        .error(R.mipmap.ic_launcher)
                        .into(avatarIV);
                }
            }

            override fun onFailure(call: Call<String>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }


    //get the result from calling for permissions in request_permission_control()
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        when (requestCode){
            REQUEST_ID_READ_EXTERNAL_STORAGE -> {
                if(grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED){
                    // Show gallery
                    selectImageGallery()
                } else {
                    Log.e(TAG, "Permiso no dado")
                }
            }
        }
    }

}
