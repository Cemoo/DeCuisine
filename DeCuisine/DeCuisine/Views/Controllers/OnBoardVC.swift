//
//  OnBoardVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 15.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class OnBoardVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: "mail") as? String {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "main", sender: self)
            }
        } else {
            delay(2) {
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
