<?php

/*
 * Convierte texto a hash
 */

if (!function_exists('hashPassword')) {

    function hashPassword($plainPassword) {
        return password_hash($plainPassword, PASSWORD_DEFAULT);
    }

}

/*
 * Verifica el hash
 */

if (!function_exists('verifyHashPassword')) {

    function verifyHashedPassword($plainPassword, $hashPassword) {
        return password_verify($plainPassword, $hashPassword);
    }

}


/*
 * Verifica si el usuario esta autentificado
 */
if (!function_exists('isLoggedIn')) {

    function isLoggedIn() {
        //Uso el CI ya que este archivo no extiende de CIController
        $CI = & get_instance();

        //$user_id = $this->session->userdata("user_id");
        $user_id = $CI->session->userdata("user_id");
        
        $loggedIn = false;
        if (isset($user_id)) {

            $loggedIn = true;
        }
        return $loggedIn;
    }

}


/*
 * Generar token auth
 */

if (!function_exists('generateTokenAuth')) {

    function generateTokenAuth($size = 50) { //100 cuando lo hacemos caracteres
        return bin2hex(openssl_random_pseudo_bytes($size));
    }

}

/*
 * Comparar token auth
 */

if (!function_exists('compareTokenAuth')) {

    function compareTokenAuth($token) {

        $CI = & get_instance();

        return $CI->User_token->findByToken($token) !== null;

    }

}

