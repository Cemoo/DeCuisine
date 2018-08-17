//
//  SignUpVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 15.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var btnReturnLogin: UIButtonDesignable!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var emailView: TextField!
    @IBOutlet weak var passView: TextField!
    @IBOutlet weak var nameView: TextField!
    @IBOutlet weak var surnameView: TextField!
    
    var userModel: UserViewModel!
    
    
    let images = [#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "IMG_0518"),#imageLiteral(resourceName: "IMG_0532")]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnReturnLoginAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        Loading.show()
        register(emailView.textfield.text ?? "", passView.textfield.text ?? "", nameView.textfield.text ?? "", surnameView.textfield.text ?? "")
    }
    
    
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
    
    func register(_ mail: String, _ password: String, _ name: String, _ surname: String) {
        Loading.hide()
        if isValidEmail(mail) {
            if password != "" {
                if name != "" {
                    if surname != "" {
                        userModel = UserViewModel()
                        let user = User(name, surname, mail, 0, password, UUID().uuidString, "")
                        userModel.addUser(user.request()) { (result) in
                            print(result)
                            if result {
                                self.message(MessageText.successRegister)
                                self.clearFields()
                            } else {
                                self.message(MessageText.failRegister)
                            }
                        }
                    } else {
                        message(MessageText.surnameEmpty)
                    }
                } else {
                    message(MessageText.nameEmpty)
                }
            } else {
                message(MessageText.passEmpty)
            }
        } else {
            message(MessageText.mailInvalid)
        }
        
        
    }
    
    func message(_ str: MessageText) {
        self.present(genericAlert("UYARI", message: str.rawValue, buttonText: "OK"), animated: true, completion: {
            Loading.hide()
        })
    }
    
    enum MessageText: String {
        case mailInvalid = "Mail geçerli değil"
        case nameEmpty = "İsim boş olamaz"
        case surnameEmpty = "Soy isim boş olamaz"
        case passEmpty = "Şifre boş olamaz"
        case successRegister = "Kullanıcı kaydı başarılı!"
        case failRegister = "Kullanıcı kaydı başarısız!"
    }
    
    private func clearFields() {
        self.view.subviews.forEach { (item) in
            if item is TextField {
                let item = item as! TextField
                item.textfield.text = ""
            }
        }
    }
    
}
