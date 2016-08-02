//
//  PokemonGettable.swift
//  PokeDex
//
//  Created by Infinum on 23/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

protocol PokemonGettable {
    func getPokemons(user: User)
}
extension PokemonGettable where Self: UIViewController {
    
    func getPokemons(user: User){
        
        NSUserDefaults.standardUserDefaults().setObject(user.authToken, forKey:
            "auth-token")
        NSUserDefaults.standardUserDefaults().setObject(user.email, forKey:
            "email")
        NSUserDefaults.standardUserDefaults().setObject(user.username, forKey:
            "username")
        
        let headers = [
            "Authorization": user.authorization,
            ]
        
        Alamofire.request(.GET, "https://pokeapi.infinum.co/api/v1/pokemons", headers: headers, encoding: .JSON).validate().responseJSON
            { (response) in
                
                switch response.result {
                case .Success:
                    print("Successful")
                    //print("\(response)")
                    do {
                        let data = response.data!
                        let pokemonList : PokemonList = try Unbox(data)
                        print("\(pokemonList.pokemons)")
                        
                        let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
                        homeViewController.user = user
                        homeViewController.pokemons = pokemonList.pokemons
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                        
                    } catch _ {
                        print("Failed")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }

}