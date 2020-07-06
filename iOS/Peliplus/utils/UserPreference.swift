//
//  UserPreference.swift
//  Peliplus
//
//  Created by Francisco Sanchez on 02/05/2020.
//  Copyright © 2020 Francisco Sanchez. All rights reserved.
//

import Foundation


class UserPreference {
    
    static var USERID = "user_id"
    static var USER_NAME = "user_name"
    static var USER_EMAIL = "user_email"
    static var USER_TOKEN = "user_token"
    static var USER_AVATAR = "user_avatar"
    
    static func setUser(user: User){
        setUserId(userId: user.userId)
        setUserName(userName: user.name)
        setUserEmail(userEmail: user.email)
        setUserToken(userToken: user.token)
    }
    
    static func closeSession(){
        setUserId(userId: 0)
        setUserName(userName: "")
        setUserEmail(userEmail: "")
        setUserToken(userToken: "")
    }
    
    static func getUserId() -> Int{
        return UserDefaults.standard.integer(forKey: USERID)
    }
    
    static func setUserId(userId: Int){
        return UserDefaults.standard.set(userId, forKey: USERID)
    }
    
    static func getUserName() -> String{
        return UserDefaults.standard.string(forKey: USER_NAME) ?? ""
    }
    
    static func setUserName(userName: String){
        return UserDefaults.standard.set(userName, forKey: USER_NAME)
    }
    
    static func getUserEmail() -> String{
        return UserDefaults.standard.string(forKey: USER_EMAIL) ?? ""
    }
    
    static func setUserEmail(userEmail: String){
        return UserDefaults.standard.set(userEmail, forKey: USER_EMAIL)
    }
    
    static func getUserToken() -> String{
        return UserDefaults.standard.string(forKey: USER_TOKEN) ?? ""
    }
    
    static func setUserToken(userToken: String){
        return UserDefaults.standard.set(userToken, forKey: USER_TOKEN)
    }
    
    static func getUserAvatar() -> String{
        return UserDefaults.standard.string(forKey: USER_AVATAR) ?? ""
    }
    
    static func setUserAvatar(userAvatar: String){
        return UserDefaults.standard.set(userAvatar, forKey: USER_AVATAR)
    }
    
    
}
