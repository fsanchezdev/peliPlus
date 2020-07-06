package com.peliplus.adr.activities.user

import android.content.Intent
import android.os.Bundle
import android.support.v4.text.HtmlCompat
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Toast
import com.peliplus.adr.R
import com.peliplus.adr.model.User
import com.peliplus.adr.restapi.RestApiAdapter
import kotlinx.android.synthetic.main.login_activity.emailET
import kotlinx.android.synthetic.main.login_activity.passwordET
import kotlinx.android.synthetic.main.register_activity.*
import retrofit2.Call
import retrofit2.Response


class RegisterActivity : AppCompatActivity() {
    val TAG = "LoginActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.register_activity)

        registerButton.setOnClickListener{
            _register()
        }

    }

    private fun _register() {
        var restApiAdapter = RestApiAdapter()
        var gson = restApiAdapter.gsonDeserizerUser()
        val endPointsApi = restApiAdapter.conection(gson)

        val call = endPointsApi.register(
            nameET.text.toString(),
            emailET.text.toString(),
            passwordET.text.toString(),
            confirmPasswordET.text.toString()
        )

        call.enqueue(object : retrofit2.Callback<User> {

            override fun onResponse(call: Call<User>, response: Response<User>) {

                var user = response.body()

                user?.let {
                    if (it.user_id == 0) {
                        print(user)
                        //read the error in html from the server
                        errorTV.text = HtmlCompat.fromHtml(
                            user.name+user.email+user.password,
                            HtmlCompat.FROM_HTML_MODE_LEGACY
                        )

                    } else {
                        var intent = Intent(this@RegisterActivity, LoginActivity::class.java)
                        startActivity(intent)

                        Toast.makeText(
                            this@RegisterActivity,
                            "Hola ${user.name}",
                            Toast.LENGTH_LONG
                        ).show()

                        finish()
                    }
                }
            }

            override fun onFailure(call: Call<User>, t: Throwable) {
                Log.e(TAG, t.toString())
            }
        })
    }

}
