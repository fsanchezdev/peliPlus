<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class Movie extends MY_Model {
    public function __construct() {
        parent::__construct();
        //$this->load->database();
    }
    
    public $table="movies";
    public $table_id="movie_id";
    
   //uso MY_Model que sobreescribe a la clase CI_model para asi tener el CRUD solo 1 vez
    
    
     function findRecords($search=array(),$type_movie_id=null , $year=null,$offset=0){
        
        $this->db->select("m.name, m.movie_id, m.year, m.image, m.type_movie_id, tm.name as type_movie");
        $this->db->from("$this->table as m");
        $this->db->join('types_movie as tm','tm.type_movie_id=m.type_movie_id','LEFT');
        
        //busqueda
        foreach ($search as $key => $value) {
            //if($value!="")
                $this->db->like('m.name',$value);
        }
        
        //filtros
        if(isset($type_movie_id)&& $type_movie_id !="") {
            $this->db->where('tm.type_movie_id',$type_movie_id);
        }
        
        if(isset($year)&& $year !="") {
            $this->db->where('year',$year);
        }
        
        //paginacion
         $this->db->limit(PAGE_SIZE,$offset);
        
        $query = $this -> db->get();
        return $query->result();
    }
    
    
     function find($id){
        
        $this->db->select("m.name, m.movie_id, m.year, m.description, m.image, m.type_movie_id, tm.name as type_movie");
        $this->db->from("$this->table as m");
        $this->db->join('types_movie as tm','tm.type_movie_id=m.type_movie_id','LEFT');
        
        $this->db->where($this->table_id,$id);
 
        $query = $this -> db->get();
        return $query->row();
    }
    
       function findAll(){
        //$this->db->select("m.* tm.name as type.movie");
        $this->db->select("m.name, m.movie_id, m.year, m.description, m.image, m.type_movie_id, tm.name as type_movie");
        $this->db->from("$this->table as m");
        $this->db->join('types_movie as tm','tm.type_movie_id=m.type_movie_id','LEFT');
        
        $query = $this -> db->get();
        return $query->result();
    }
}
