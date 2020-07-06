<html>
    <head>

    </head>
    <body>
        <link rel="stylesheet" href="<?php echo base_url() ?>assets/css/login.css"  id="bootstrap-css">
        <link rel="stylesheet" href="<?php echo base_url() ?>assets/css/bootstrap.min.css"  id="bootstrap-css">
  
        <!------ Include the above in your HEAD tag ---------->

        <div class="wrapper <?php echo (validation_errors()!=="" || $this->session->flashdata('error')!=="")? "": fadeInDown ?>">
            <div id="formContent">
                <!-- Tabs Titles -->

              
                <!-- Icon -->
                <div class="fadeIn first">
                    <img src="<?php echo base_url() ?>assets/img/original.png" id="icon" alt="User Icon" />
                </div>

                <!-- Login Form -->
                <form method="POST" action="">
                    <input type="text" id="login" class="fadeIn second" name="email" placeholder="login">
                    <input type="password" id="password" class="fadeIn third" name="password" placeholder="password">
                      
                    <?php if(validation_errors()!="" || $this->session->flashdata('error')!=""): ?>
                        <div class="alert alert-danger mx-5 mt-2" role="alert">
                            <p><?php echo validation_errors() ?><?php echo $this->session->flashdata('error')?></p>
                        </div>
                    <?php endif; ?>
                    
                  
                    
                    <input type="submit" class="fadeIn fourth" value="Log In">
                </form>

                <!-- Remind Passowrd -->
                <div id="formFooter">
                    <a class="underlineHover" href="#">Forgot Password?</a>
                </div>

            </div>
        </div>
        
        <script src="<?php echo base_url() ?>assets/js/jquery-3.2.1.slim.min.js" ></script>
        <script src="<?php echo base_url() ?>assets/js/popper.min.js" ></script>
        <script src="<?php echo base_url() ?>assets/js/bootstrap.min.js"></script>
    </body>
</html>