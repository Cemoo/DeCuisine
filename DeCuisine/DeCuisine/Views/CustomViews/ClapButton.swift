//
//  ClapButton.swift
//  DeCuisine
//
//  Created by Erencan Evren on 8.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

@IBDesignable
class ClapButton: UIButton {
    
    var clapCount: Int = 0 {
        didSet {
            self.updateClapCount()
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
      
    }
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.white  {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
        
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
        
    }
    
    override func awakeFromNib() {
        self.imageView?.image = #imageLiteral(resourceName: "clap")
        setupLongGestureRecognizer()
    }
    
    @objc func longPressed(gesture: UILongPressGestureRecognizer) {
       
    }
  
    //MARK: Can be optimize!!
    func clap() {
        var clapEnded = false
        if self.imageView?.image == #imageLiteral(resourceName: "clap") {
            DispatchQueue.main.async {
                self.isSelected = true
                self.imageView?.image = #imageLiteral(resourceName: "clapend")
                self.borderColor = UIColor.clear
                
            }
        }
        self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
            [unowned self] in
            if clapEnded == false {
                self.transform = .identity
                DispatchQueue.main.async {
                    self.borderColor = UIColor.black
                    clapEnded = true
                }
            }
        }) { (true) in
            clapEnded = false
        }
 
    }
    
    private func updateClapCount() {
        
    }
    
    private func setupLongGestureRecognizer() {
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(gesture:))))
    }
    
}


protocol ClapButtonDelegate: class {
    func touchedIn()
}


