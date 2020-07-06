//
//  DetailViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 30/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import Cosmos


class DetailViewController: UIViewController {
    var movie : Movie!
    var cMovie : CMovie?
    var favorite : Int! = 0
    
    @IBOutlet var movieIV: UIImageView!
    //@IBOutlet var descripLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet var movieLabel: UILabel!
    
    @IBOutlet weak var ratingCosmos: CosmosView!
    
    // sociales
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var qualificationLabel: UILabel!
    
    
    
    @IBAction func shareOnClick(_ sender: UIButton) {
        _animateButtonSocial(sender: sender)
        _share()
    }
    
    @IBAction func favoriteOnClick(_ sender: UIButton) {
        
        _animateButtonSocial(sender: sender)
        _favorite()
    }
    
    private func _animateButtonSocial(sender: UIButton){
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform=CGAffineTransform(scaleX: 1.5, y: 1.5)
            sender.alpha=0.3
        },completion:{
            finished in
            sender.transform=CGAffineTransform(scaleX: 1.0, y: 1.0)
            sender.alpha=1
        })
    }
    
    override func viewDidLoad(){
        _movieDetail()
        
        
        
    }
     //this is called when you want to go to califications
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "userCalificationSeque" {
            let userCalificationViewController = segue.destination as! UserCalificationViewController
            
            if self.cMovie?.qualifications != nil {
                userCalificationViewController.movie = (self.cMovie)!
            }
        }
    }
    
    
    
    
    
    private func _movieDetail(){
        //we could send it directly with the format
        /*parameters: [
         "offset": filterMovie.offset,
         "name": filterMovie.name,
         "year": filterMovie.year]*/
        var parameters: Dictionary<String, Int> = ["": 0]
        
        if UserPreference.getUserId() > 0 {
            parameters = ["user_id": UserPreference.getUserId()]
        }
        
        AF.request(ResourceURL.URL_SHOW_MOVIE+"\(movie.movieId!)", method: .get, parameters: parameters).responseDecodable { (response:
            AFDataResponse<CMovie>) in
            
            if response.error == nil {
                
                self.cMovie = response.value
                
                
                if self.cMovie?.favorite != nil {
                    self.favorite = 1
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: UIControl.State.normal)
                }
                
                
               /* if self.cMovie!.average!.average != nil {
                    self.qualificationLabel.text = "Calificación: \(self.cMovie!.average!.average!)"
                }*/
                self.qualificationLabel.text = self.cMovie?.average?.average
                == nil
                ? "Na" : self.cMovie?.average?.average
                
                self.movieLabel.text = self.cMovie?.name
                self.descriptionTV.text = self.cMovie?.descrip
                self._imgMovieLoad(image:self.cMovie!.image)
                
            } else {
                print(response.error!)
            }
        }
    }
    
    private func _imgMovieLoad(image: String){
        AF.request("\(ResourceURL.URL_IMG_BASE)\(image)").response { response in
            
            if response.error == nil {
                
                self.movieIV.image = UIImage(data: response.data!)
                
            } else {
                print(response.error!)
            }
            
            
        }
    }
    
    
    private func _favorite(){
        
        if UserPreference.getUserId() != 0 {
            
            
            if favorite == 1 {
                favorite = 0
            }else {
                favorite = 1
            }
            
            let parameters : Dictionary<String, Any> = [
                "user_id": UserPreference.getUserId(),
                "token": UserPreference.getUserToken(),
                "movie_id": cMovie!.movieId!,
                "favorite": favorite!
            ]
            
            print(parameters)
            
            AF.request(ResourceURL.URL_POST_FAVORITE, method: .post, parameters: parameters
            ).responseDecodable { (response:
                AFDataResponse<CSimple>) in
                
                if response.error == nil {
                    
                    if response.value?.res == "ok" {
                        if self.favorite == 1 {
                            self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: UIControl.State.normal)
                        }else {
                            self.favoriteButton.setImage(#imageLiteral(resourceName: "unfavorite"), for: UIControl.State.normal)
                        }
                    }
                    
                } else {
                    print(response.error!)
                }
                
                
            }
        }
        
    }
    
    private func _share(){
        let activityViewController = UIActivityViewController(activityItems: [cMovie!.name,movieIV.image], applicationActivities: nil)
        
        //startActivity in android
        self.present(activityViewController, animated: true)
    }
    
    private func _rating(qualification:Double){
        
        if UserPreference.getUserId() != 0 {
            let parameters : Dictionary<String, Any> = [
                "user_id": UserPreference.getUserId(),
                "token": UserPreference.getUserToken(),
                "movie_id": cMovie!.movieId!,
                "qualification": qualification
            ]
            
            
            
            AF.request(ResourceURL.URL_POST_QUALIFICATION, method: .post, parameters: parameters
            ).responseDecodable { (response:
                AFDataResponse<CSimple>) in
                
                if response.error == nil {
                    
                    if response.value?.res == "ok" {
                        
                    }
                    
                } else {
                    print(response.error!)
                }
                
                
            }
        }
    }
}
