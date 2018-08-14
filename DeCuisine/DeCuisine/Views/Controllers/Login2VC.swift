//
//  Login2VC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 14.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class Login2VC: UIViewController {

    @IBOutlet weak var şmgTest: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }

    func animate() {
        DispatchQueue.main.async {
            UIView.transition(with: self.şmgTest, duration: 10, options: [.transitionCrossDissolve], animations: {
                self.şmgTest.image = #imageLiteral(resourceName: "img1")
            }) { (succ) in
                self.animate()
            }
        }
       
    }

}
