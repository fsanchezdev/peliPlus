//
//  RegisterViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 04/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController : UIViewController{
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var repeatPasswotdTF: UITextField!
    
    var user = User(name: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerOnClick(_ sender: Any) {
        _register()
    }
    
    
    private func _register(){
        AF.request(ResourceURL.URL_POST_USER_SIGN_UP, method: .post,
            parameters: [
            "password": passwordTF.text,
            "confirm_password": repeatPasswotdTF.text,
            "email": emailTF.text,
            "name": nameTF.text]
            ).responseDecodable { (response:
                AFDataResponse<CUser>) in
                
                //print(response.value)
                
                if response.error == nil {
                    self.user = User(cUser: response.value!)
                    
                    if self.user.userId > 0 {
                        
                        Utils.showToast(controller: self, message: "Registro exitoso, por favor inicia sesión", seconds: 2)
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    } else {
                        // ocurrio un error con el registro
                        let html = response.value!.email +
                            response.value!.name +
                            response.value!.password!
                        self.webView.loadHTMLString(html, baseURL: nil)
                        
                    }
                    
                    
                } else {
                    print(response.error!)
                }
                
                
        }
    }
}
