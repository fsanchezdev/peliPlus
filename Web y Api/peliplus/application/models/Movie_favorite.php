<?php

class Movie_favorite extends MY_Model {

    public function __construct() {
        parent::__construct();
    }

    public $table = "movie_favorites";
    public $table_id = "movie_favorite_id";

    //Search the favorite movies from the user
    function findByUserIdAndMovieId($userId, $movieId) {
        $this->db->select();
        $this->db->from($this->table);
        $this->db->where("user_id", $userId);
        $this->db->where("movie_id", $movieId);

        $query = $this->db->get();
        return $query->row();
    }
    //search the movie and take it if it's favorite
    function findByMovieId($movieId) {
        $this->db->select();
        $this->db->from($this->table);
        $this->db->where("movie_id", $movieId);

        $query = $this->db->get();
        return $query->result();
    }
    //Delete indicated favorite
    function deleteByUserIdAndMovieId($userId, $movieId) {
        $this->db->where("user_id", $userId);
        $this->db->where("movie_id", $movieId);
        $this->db->delete($this->table);
    }

}
