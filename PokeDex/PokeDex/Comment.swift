//
//  Comment.swift
//  PokeDex
//
//  Created by Infinum on 11/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation

import Unbox
import Alamofire
import MBProgressHUD

struct Comment: Unboxable {
    
    let content: String?
    let userId: String?
    
    init(unboxer: Unboxer) {
        
        content = unboxer.unbox("attributes.content")
        userId = unboxer.unbox("relationships.author.data.id")
    }
    
//    func getUser(authorization: String) -> User {
//        
//        let headers = ["Authorization": authorization,]
//        
//        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/users/"+userId!, headers: headers, encoding: .JSON).validate().responseJSON
//            { (response) in
//
//                switch response.result {
//                case .Success:
//                    print("Successful")
//                    
//                    do {
//                        let data = response.data!
//                        let commentUser : CommentUser = try Unbox(data)
//                        //usernameLoaded(commentUser.username)
//                        
//                    } catch _ {
//                        print("Failed")
//                    }
//                case .Failure(let error):
//                    print(error)
//                }
//        }
//    }
//    
//    func getUsername(authorization: String) -> String {
//        return getUser(authorization).username
//    }
//    
//    func usernameLoaded(){
//    
//    }
}
