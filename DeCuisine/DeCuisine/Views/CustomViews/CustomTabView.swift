//
//  CustomTabView.swift
//  DeCuisine
//
//  Created by Erencan Evren on 14.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTabView: UIView {
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btright: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    private var isLeft = false
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - setup
    fileprivate func setupView() {
        isLeft = true
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    
    @IBAction func btnLeftAction(_ sender: Any) {
        animateBottomView(for: .right)
    }
    
    @IBAction func btnRightAction(_ sender: Any) {
        animateBottomView(for: .left)
    }
    
    private func animateBottomView(for button: Button) {
        switch button {
        case .left:
            UIView.animate(withDuration: 0.4) {
                self.bottomView.layer.position.x = self.btnLeft.frame.width * 1.5
                self.bottomView.layoutIfNeeded()
            }
        case .right:
            UIView.animate(withDuration: 0.4) {
                self.bottomView.layer.position.x = self.btnLeft.frame.width * 0.5
                self.bottomView.layoutIfNeeded()
            }
        }
    }
    
    
    /// Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}

enum Button {
    case left,right
}






















