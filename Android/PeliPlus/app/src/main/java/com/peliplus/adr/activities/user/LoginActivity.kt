package com.peliplus.adr.activities.user

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Toast
import com.peliplus.adr.MainActivity
import com.peliplus.adr.R
import com.peliplus.adr.model.User
import com.peliplus.adr.restapi.RestApiAdapter
import com.peliplus.adr.utils.UserPreferences
import kotlinx.android.synthetic.main.login_activity.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class LoginActivity : AppCompatActivity() {
    val TAG = "LoginActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.login_activity)

        loginButton.setOnClickListener{
            _login()
        }
        /*loginButton.setOnClickListener(){
            _login()
        }*/


        registerTV.setOnClickListener {
            var intent = Intent(this@LoginActivity, RegisterActivity::class.java)
            startActivity(intent)
        }

    }
    //try to login in the app
    private fun _login() {
        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerUser()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.login(
            emailET.text.toString(),
            passwordET.text.toString()
        )

        call.enqueue(object : Callback<User> {

            override fun onResponse(call: Call<User>, response: Response<User>) {

                var user = response.body()

                //executes when our user isn't null
                user?.let {
                    if (it.user_id == 0) {
                        //text in cloud
                        Toast.makeText(
                            this@LoginActivity,
                            "Usuario o contraseña incorrecta",
                            Toast.LENGTH_LONG
                        ).show()
                    } else {
                        UserPreferences.getUser(this@LoginActivity, user)
                        //intent is for navigate
                        var intent = Intent(this@LoginActivity,MainActivity::class.java)
                        startActivity(intent)

                        Toast.makeText(
                            this@LoginActivity,
                            "Hola ${user.name}",
                            Toast.LENGTH_LONG
                        ).show()

                        finish() //try to change it
                    }
                }
            }

            override fun onFailure(call: Call<User>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }

}
