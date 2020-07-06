//
//  Utils.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 02/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func showToast(controller: UIViewController, message: String, seconds: Double = 2){
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.view.alpha = 0.7 //Color
        alertController.view.layer.cornerRadius = 15
        
        //Close alert
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alertController.dismiss(animated: true)
        }
        
        controller.present(alertController, animated: true)
    
    }
}
