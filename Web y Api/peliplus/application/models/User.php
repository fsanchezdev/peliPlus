<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class User extends MY_Model {

    public function __construct() {
        parent::__construct();
        //$this->load->database();
    }

    public $table = "users";
    public $table_id = "user_id";

    //uso MY_Model que sobreescribe a la clase CI_model para asi tener el CRUD solo 1 vez


    function checkLogin($email, $plainPassword) {

        $this->db->select();
        $this->db->from($this->table);
        $this->db->where("email", $email);

        $query = $this->db->get();
     
        $user=$query->row();
          
        $myUser=null;
        if(!empty($user)){
            if(verifyHashedPassword($plainPassword, $user->password)){
                $myUser=$user;
            }
        }else {
           
        }
        
        return  $myUser;
    }

     function findByMovieId($movie_id) {
        $this->db->select("u.name, u.email, u.user_id");
        $this->db->from("$this->table as u");
        $this->db->join('movie_qualifications as mq', 'mq.user_id = u.user_id');
        $this->db->where("mq.movie_id", $movie_id);

        $query = $this->db->get();
        return $query->result();
    }

    
    
}
