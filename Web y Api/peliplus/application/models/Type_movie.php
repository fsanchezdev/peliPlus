<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class Type_Movie extends MY_Model {
    public function __construct() {
        parent::__construct();
        //$this->load->database();
    }
    
    public $table="types_movie";
    public $table_id="type_movie_id";
    
    
}
