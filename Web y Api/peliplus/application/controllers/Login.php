<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {

    public function __construct() {

        parent::__construct();

        $this->load->model('User');
        
        $this->load->helper('url');
        $this->load->helper('user');
        $this->load->library('session');
    }

    public function index() {
       
        //echo hashPassword('12345');
        //echo verifyHashPassword('12345', hashPassword('12345'));
        //if(!$this->isLoggedIn()) {
          if(!isLoggedIn()) {
            $this->login();
            $this->load->view("user/login") ;
       
        } else 
            redirect("/core/Dashboard");
           
    }
    
    
    public function logout() {
        //preguntamos por la uri
        if($this->uri->uri_string()=="login/logout")
            show_404 ();
        
        
        $this->session->sess_destroy();
        
         //$this->load->view("user/login"); se llama al controlador no a la vista
          redirect("/login");
    }

    /*private function isLoggedIn() { //movida a user_helper para mayor seguridad
    
        $user_id = $this->session->userdata("user_id");
        
        $loggedIn = false;
        if (isset($user_id)) {

            $loggedIn = true;
        }
        return $loggedIn;
    }*/

    private function login() {
        $this->load->helper(array('form', 'url'));

        $this->load->library('form_validation');

        //reglas de validacion
        $this->form_validation->set_rules('password', 'Password', 'required|max_length[20]');
        $this->form_validation->set_rules('email', 'Email', 'required|max_length[30]|valid_email|trim');

        //Verificar las reglas de validación
        if ($this->form_validation->run() == FALSE) {
            //$this->load->view('myform');
        } else {
            //$this->load->view('formsuccess');
            
            //Formulario valido
            
            //Obtenemos datos usuario
            $email = $this->input->post('email');
            $password = $this->input->post('password');

            $user = $this->User->checkLogin($email, $password);

            if (is_object($user)) {
                //echo 'Autentificado';
                $sessionUser = array(
                    'user_id' => $user->user_id,
                    'email' => $user->email,
                    'name' => $user->name);

                
                //Sesion de usuario, set session in admin module
                $this->session->set_userdata($sessionUser); //lives until times expires
                $this->session->set_flashdata('success', "Bienvenido $user->name"); //lives until next petition
                $this->session->set_flashdata('msj', "success"); 
                
                redirect("/core/Dashboard");
            } else {
                $this->session->set_flashdata('error', "Email o contraseña incorrecta");
                $this->session->set_flashdata('msj', "error"); 
              //  echo "Email o contraseña incorrecta";
            }
        }
    }

}
