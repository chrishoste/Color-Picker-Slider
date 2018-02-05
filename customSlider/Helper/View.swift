//
//  View.swift
//  customSlider
//
//  Created by Christophe Hoste on 04.02.18.
//  Copyright © 2018 Christophe Hoste. All rights reserved.
//

import UIKit

class View: UIView {
    
    var view: UIView!
    
    func xibSetup(xibName: String) {
        view = loadViewFromNib(xibName: xibName)
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib(xibName: String) -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: xibName, bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0]
        
        if let currentView = view as? UIView {
            return currentView
        } else {
            return UIView()
        }
    }
}
