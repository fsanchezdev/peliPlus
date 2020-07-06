<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class MY_Model extends CI_Model{
    
    
    public function __construct() {
        parent::__construct();
        $this->load->database();
    }
    

    
    
    
    function findAll(){
        $this->db->select();
        $this->db->from($this->table);
        
        $query = $this -> db->get();
        return $query->result();
    }
    
    function find($id) {
        $this->db->select();
        $this->db->from($this->table);
        $this->db->where($this->table_id,$id);
        
        $query=$this->db->get();
        return $query->row();
    }
    
    function update($id,$data){
        $this->db->where($this->table_id,$id);
        $this->db->update($this->table,$data);
        
    }
    
    function delete($id){
        $this->db->where($this->table_id,$id);
        $this->db->delete($this->table);
        
    }
    
    function insert($data){
        $this->db->insert($this->table,$data);
        
    
        return $this->db->insert_id();
    }
    
    function count(){
        //$count=$this->db->query('select '+$this->table_id+' from '+ $this->table);
        $count=$this->db->query("select $this->table_id from  $this->table");
        return $count->num_rows();
    }
    
}

