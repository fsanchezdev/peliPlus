//
//  UserCalificationViewController.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 07/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//


import UIKit
import Alamofire
import Cosmos

class UserCalificationViewController: UIViewController,UICollectionViewDelegate{
    
    /*var images=[UIImage(named:"favorite"),
                UIImage(named:"favorite"),
                UIImage(named:"favorite"),
                UIImage(named:"favorite"),
    ]*/
    //let qualifications:[CQualification]?=[]
    
    @IBOutlet weak var myCosmos: CosmosView!
    var movie: CMovie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(qualifications?.count)
        myCosmos.settings.fillMode = .half
        
        if let average = movie!.average?.average {
            if let dAverage = Double(average) {
                myCosmos.rating = dAverage
            }
        }
        //onchange cosmos rating
        myCosmos.didTouchCosmos = {
            rating in
            self._raiting(qualification: rating)
        }
    }
    
    @IBAction func closeDialog(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    private func _imgAvatar(avatar: String, imageIV: UIImageView){
        AF.request(ResourceURL.URL_GET_USER_AVATAR_RESOURCE + avatar).response { response in
            
            if response.error == nil {
                imageIV.image = UIImage(data: response.data!)
            } else {
                print(response.error!)
            }
        }
    }
    
    private func _raiting(qualification: Double){
        if UserPreference.getUserId() == 0 {
            return
        }
        
        let parameters : Dictionary<String, Any> = [
            "user_id": UserPreference.getUserId(),
            "token": UserPreference.getUserToken(),
            "movie_id": movie!.movieId!,
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

extension UserCalificationViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return images.count
        return movie!.qualifications!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                                                                        //important
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserCalificationCell
        
       // cell.avatarIV.image=images[indexPath.row]
       // cell.nameLabel.text = movie!.qualifications![indexPath.row].name
       
        
        _imgAvatar(avatar: movie!.qualifications![indexPath.row].avatar, imageIV: cell.avatarIV)
        cell.nameLabel.text = movie!.qualifications![indexPath.row].name
        
        return cell
    }
}
