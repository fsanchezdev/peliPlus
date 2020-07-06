//
//  SearchViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 02/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var search: String = ""
    var year: String = ""
    var typeMovieSelected:String=""
    var typesMovie : [CTypeMovie] = []
    var typeMovieRow=0
    //When it's needed, this 2 variables aren´t created, the
    //controller is waiting the method prepare, so thats why we need the 2 variables above this
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    
    @IBOutlet weak var typeMoviePV: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTF.text = search
        yearTF.text = year
        
        //same as picking the component and drag it with ctrl to the view controller of herself
        typeMoviePV.dataSource=self
        typeMoviePV.delegate=self
        
        _typeMovies()
    }
    
    
    @IBOutlet weak var filterOnClink: NSLayoutConstraint!
    
    
    private func _typeMovies(){
           AF.request(ResourceURL.URL_SHOW_ALL_TYPES_MOVIE, method: .get
           ).responseDecodable { (response:
           AFDataResponse<[CTypeMovie]>) in
               //    print(response.response?.url)
                 if response.error==nil{
                    //Default value
                    self.typesMovie.append(CTypeMovie(typeMovieId: "", name: "Tipos de pelicula"))
                    
                    self.typesMovie.append(contentsOf: response.value!)
                     //self.typesMovie=response.value!
                    //print(self.typesMovie)
                 
                    //need to reload after because async
                    self.typeMoviePV.reloadAllComponents()
                    //select the type stored
                    self.typeMoviePV.selectRow(self.typeMovieRow , inComponent: 0, animated: true)
                 } else{
                      print(response.error!)
                 }
             }
       }
       
       private func _imgMovieLoad(image:String,imageIV:UIImageView){
              AF.request(ResourceURL.URL_IMG_BASE+image).response{response  in
                           
                           if response.error==nil{
                             //print(response.value!)
                             
                              imageIV.image=UIImage(data:response.data!)
                           } else{
                                print(response.error!)
                           }
                       }
          }
}
extension SearchViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //How many rows for each copmponent
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.typesMovie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.typesMovie[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeMovieSelected=self.typesMovie[row].typeMovieId
        typeMovieRow=row
    }
    
}
