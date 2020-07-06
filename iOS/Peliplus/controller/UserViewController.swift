//
//  UserViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 04/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//


import Foundation
import UIKit
import Alamofire

class UserViewController : UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet weak var avatarIV: UIImageView!
    
    @IBOutlet var nombreTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.text = UserPreference.getUserEmail()
        nombreTF.text = UserPreference.getUserName()
        _loadAvatar()
        
    }
    
    
    @IBAction func CloseSessionOnClick(_ sender: Any) {
        UserPreference.closeSession()
        
       Utils.showToast(controller: self, message: "Sesión cerrada con exito", seconds: 2)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            //Redirect to last view
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func imageChoice(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                imagePickerController.allowsEditing = false
                
                self.present(imagePickerController,animated: true,completion: nil)
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
       if let img = info[.originalImage] as? UIImage {
           self.avatarIV.image = img
           _sendImages()
       } else {
           print("Imagen no seleccionada")
       }
       
       self.dismiss(animated: true, completion: nil)
   }
    
    
    private func _sendImages(){
        
        if let image = avatarIV.image {
            //always if to avoid crashes
            if let dataImage = image.jpegData(compressionQuality: 0.8) {

                AF.upload(multipartFormData: { (multipartFormData) in
                    multipartFormData.append(dataImage, withName: "image", fileName: "avatar.jpg", mimeType: "image/jpg")
                }, to: ResourceURL.URL_POST_USER_AVATAR + String(describing: UserPreference.getUserId()))
                    .responseDecodable { (response:
                        AFDataResponse<CSimple>) in
                        
                        if response.error == nil {
                                                                    //a != nil ? a! : b, return "" if is nil, and res if isn´t
                            UserPreference.setUserAvatar(userAvatar: response.value?.res ?? "")
                            
                        } else {
                            print(response.error!)
                        }

                }
                
            }
            
        }

    }
    
    private func _loadAvatar(){
        
        if UserPreference.getUserAvatar() != "" {
             AF.request(ResourceURL.URL_GET_USER_AVATAR_RESOURCE + UserPreference.getUserAvatar()).response { response in
                       
                       if response.error == nil {
                           self.avatarIV.image = UIImage(data:
                            //TODO capture file maximun size error, same in android
                            response.data!)
                       } else {
                           print(response.error!)
                       }

                   }
        }
        
       
    }
    
}
