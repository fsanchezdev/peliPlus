<?php
//phpinfo();
use chriskacerguis\RestServer\RestController;

require APPPATH . '/libraries/RestController.php';
require APPPATH . '/libraries/Format.php';

class Api extends RestController {

  
    
    public function data_get(){
        
        $this->load->model('Movie');
       /* $data=array('dato1' =>1,
                    'dato2' => 2);
        */
        $data=$this->Movie->findAll();
        
        $this->response($data);
        
     
    }
}