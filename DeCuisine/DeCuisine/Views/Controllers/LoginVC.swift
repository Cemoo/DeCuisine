//
//  LoginVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 14.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        
    }
    
    func animate() {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 50) {
                self.leading.constant = -(self.stackView.frame.width - self.view.frame.width)
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    

}


