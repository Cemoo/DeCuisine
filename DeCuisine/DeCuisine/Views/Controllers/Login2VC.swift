//
//  Login2VC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 14.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class Login2VC: UIViewController {

    let images = [#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "IMG_0518"),#imageLiteral(resourceName: "IMG_0532")]
    var index = 0
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var emailText: TextField!
    @IBOutlet weak var passText: TextField!
    @IBOutlet weak var imgSplash: UIImageView!
    @IBOutlet weak var imgLogo: UIImageViewDesignable!
    @IBOutlet weak var mainView: UIView!
    
    var userModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
      
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        animateSplashImage()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @IBOutlet weak var splashImageY: NSLayoutConstraint!
    
    func animate() {
        DispatchQueue.main.async {
            UIView.transition(with: self.imgBack, duration: 10, options: [.transitionCrossDissolve], animations: {
                self.imgBack.image = self.images[self.index]
                if self.index == self.images.count - 1 {
                    self.index = 0
                } else {
                    self.index += 1
                }
                print(self.index)
            }) { (succ) in
                self.animate()
            }
        }
    }
    
    func animateSplashImage() {
        print(self.imgLogo.layer.position.y)
        print(self.imgSplash.layer.position.y)
        
        UIView.animate(withDuration: 1) {
           
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.splashImageY.constant = -self.imgLogo.center.y * 2
            self.imgSplash.transform = CGAffineTransform(scaleX: self.imgLogo.frame.width / self.imgSplash.frame.width, y: self.imgLogo.frame.height / self.imgSplash.frame.height)
            
            self.view.layoutIfNeeded()
        }) { (suc) in
            self.imgLogo.isHidden = true
            UIView.animate(withDuration: 0.4, animations: {
                self.mainView.alpha = 1
            })
            self.view.layoutIfNeeded()
        }
        
    }

    func login(_ username: String, _ pass: String) {
        if username != "" {
            self.dismissKeyboard()
            if isValidEmail(username) {
                if pass != "" {
                    userModel = UserViewModel(mail: username, pass: pass )
                    userModel.getUser { (result) in
                        if result {
                            self.performSegue(withIdentifier: "main", sender: self)
                            self.saveUserInfo(self.userModel.user!)
                        } else {
                            let alert = genericAlert("UYARI", message: "Lütfen bilgilerinizi kontrol ediniz", buttonText: "OK")
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    let alert = genericAlert("UYARI", message: "Lütfen bilgilerinizi kontrol ediniz", buttonText: "OK")
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = genericAlert("UYARI", message: "Lütfen bilgilerinizi kontrol ediniz", buttonText: "OK")
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = genericAlert("UYARI", message: "Lütfen bilgilerinizi kontrol ediniz", buttonText: "OK")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func saveUserInfo(_ user: User) {
        UserDefaults.standard.set(user.mail, forKey: "mail")
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.synchronize()
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
        self.performSegue(withIdentifier: "signup", sender: self)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        login(emailText.textfield.text ?? "", passText.textfield.text ?? "")
    }
}
