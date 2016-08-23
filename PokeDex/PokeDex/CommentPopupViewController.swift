//
//  CommentPopupViewController.swift
//  PokeDex
//
//  Created by Infinum on 10/08/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

class CommentPopupViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var blur: UIView!
    
    weak var delegate: CommentAddedDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.becomeFirstResponder()
        blur.alpha = 0.7
    }

    @IBAction func cancelButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitButtonClick(sender: AnyObject) {
        
        guard let content = commentTextField.text else {
            return
        }
        
        delegate?.didAddComment(content)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
