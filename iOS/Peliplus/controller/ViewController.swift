//
//  ViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 29/04/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //var movies=["Jocker","John Wick","Vengadores"]
    
    var movies:[Movie]=[]
    var auxMovies:[Movie]=[]
    var PAGE_SIZE=4
    
    struct FilterMovie {
        var offset: Int
        var name: String
        var year: String
        var typeMovie:String
        var typeMovieRow:Int
    }
    
    var filterMovie = FilterMovie(offset: 0, name: "", year: "",typeMovie:"",typeMovieRow: 0)
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //Charged view? now call the api rest and load the data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserPreference.getUserId() > 0 {
                   _ifAuth()
        	}
        
        _movies(reload:false)
        
        // Utils.showToast(controller: self,message: "Hola mundo",seconds: 2)
        
    }
    /**
     Call the api rest
     */
    private func _movies(reload:Bool=true){
        AF.request(ResourceURL.URL_SHOW_ALL_MOVIES, method: .get, parameters: [
            "offset": filterMovie.offset,
            "name": filterMovie.name,
            "year": filterMovie.year,
            "type_movie_id": filterMovie.typeMovie]
        ).responseDecodable { (response:
            AFDataResponse<[CMovie]>) in
            //	print(response.response?.url)
            if response.error==nil{
                self.auxMovies=Movie.cMoviesToMovies(cMovies: response.value!)
                 
                if !reload {
                    self.movies=self.auxMovies
                    self.tableView.reloadData()
                } else {
                    if self.auxMovies.count>0{
                        self.movies.append(contentsOf: self.auxMovies)
                        //Search from the last 5 movies to the actual
                        let indexPaths = (self.movies.count - self.auxMovies.count ..< self.movies.count).map {
                            //$0, the first parameter
                            IndexPath(row: $0, section: 0) }
                        
                        /*for i in 0..<5{
                         same structure
                         }*/
                        
                        
                        //print("\(indexPaths)")
                        
                        //UITableView.RowAnimation
                        self.tableView.insertRows(at: indexPaths, with:.fade)
                        
                        self.tableView.scrollToRow(at: indexPaths[0], at: .bottom, animated: true)
                    }
                    //print(indexPaths)
                    
                }
                
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
    
    
    private func _ifAuth(){
       
        AF.request(ResourceURL.URL_GET_USER_IS_LOGIN + UserPreference.getUserToken(), method: .get
            ).responseDecodable { (response:
                AFDataResponse<CSimple>) in
                if response.error == nil {
                    if response.value?.res == "" {
                        // Cerrar sesion
                        UserPreference.closeSession()
                    }
                    
                } else {
                    print("Fallo verificación Login \(response.error!)")
                }
        }
    }
    
    //pagination
    //Indicates in wich position the user is, to know when our user reaches the last index
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row==movies.count-1{
            //print("Llegue al final \(filterMovie.offset)")
            filterMovie.offset+=PAGE_SIZE
            //reload table to paginate
            _movies()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        let cellID="MovieCell"
        
        let cell=self.tableView.dequeueReusableCell(withIdentifier: cellID,for:indexPath) as!	 MovieCell
        
        /*cell.textLabel?.text=movies[indexPath.row].name
         cell.imageView?.image=#imageLiteral(resourceName: "avengers-inifity-war")*/
        
        cell.movieImage.image=#imageLiteral(resourceName: "avengers-inifity-war")
        
        self._imgMovieLoad(image: movies[indexPath.row].image, imageIV:  cell.movieImage)
        cell.movieLabel.text=movies[indexPath.row].name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView:UITableView)->Int{
        return 1
    }
    
    //this is called when you want to go to details or filter
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showMovieDetail"{
            if let indexPath=self.tableView.indexPathForSelectedRow{
                let selectedMovie=self.movies[indexPath.row]
                //look for the controller where we want to go
                let destinationViewController=segue.destination as! DetailViewController
                //add  values needed for  the view
                destinationViewController.movie=selectedMovie
            }
        }else if segue.identifier == "filterData" {
            let source = segue.destination as! SearchViewController
            
            //source.searchTF.text=filterMovie.name
            //thi are the properties of searchview
            source.search=filterMovie.name
            source.year = filterMovie.year
            source.typeMovieSelected=filterMovie.typeMovie
            source.typeMovieRow=filterMovie.typeMovieRow
        }
    }
    
    
    //Return from the filter to the list and update the data
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        
        if segue.identifier == "sendData" {
            
            let source = segue.source as! SearchViewController
            
            //print(source.searchTF.text)
            //print("Retorno a view controller")
            
            filterMovie.offset = 0
            filterMovie.name = String(source.searchTF.text!)
            filterMovie.year = String(source.yearTF.text!)
            filterMovie.typeMovie = String(source.typeMovieSelected)
            filterMovie.typeMovieRow=Int(source.typeMovieRow)
            
            movies = []
            auxMovies = []
            
            _movies(reload: false)
            
        }
    }
    
    @IBAction func userBarOnClick(_ sender: Any) {
        
        if UserPreference.getUserId() > 0 {
            performSegue(withIdentifier: "UserDetail", sender: self)
        } else {
            performSegue(withIdentifier: "UserLogin", sender: self)
        }
        
    }
}

