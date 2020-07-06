//
//  LoginViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 04/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController : UIViewController {
    
    var user = User(name: "")
    
    @IBOutlet var useremailTF: UITextField!
    
    @IBOutlet var userpasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserPreference.getUserId())
        
    }
    @IBAction func loginOnClick(_ sender: Any) {
        _login()
    }
    
    private func _login(){
        AF.request(ResourceURL.URL_POST_USER_LOGIN, method: .post, parameters: [
            "password": userpasswordTF.text,
            "email": useremailTF.text]
            ).responseDecodable { (response:
                AFDataResponse<CUser>) in
                
                if response.error == nil {
                                //Recieves a cosable, we cast it
                    self.user = User(cUser: response.value!)
        
                    if self.user.userId > 0 {
                        //print(self.user)
                        UserPreference.setUser(user: self.user)
                        
                        //print(self.user.token)
                        
                        Utils.showToast(controller: self, message: "Hola  \(String( self.user.name))", seconds: 2)
                   //Redirect to last view
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    } else {
                        // ocurrio un error con el login
                        
                        let alertController = UIAlertController(title: "Error", message: "Contraseña y/o email incorrecto", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Ok", style:.default)
                        alertController.addAction(action)
                        
                        self.present(alertController, animated: true)
                        
                    }
                    
                    
                } else {
                    print(response.error!)
                }
                
                
        }
    }
    
}
