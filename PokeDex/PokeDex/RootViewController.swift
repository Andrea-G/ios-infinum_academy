//
//  RootViewController.swift
//  PokeDex
//
//  Created by Infinum on 09/07/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

import MBProgressHUD

class RootViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonClick(sender: UIButton) {
        
        //print(usernameTextField.text)
        //print(passwordTextField.text)
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        performSelector(#selector(RootViewController.login), withObject: nil, afterDelay: 3)
    }

    @IBAction func signUpButtonClick(sender: AnyObject) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("signup") as! ViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func login() {
        MBProgressHUD.hideHUDForView(view, animated: true)
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
