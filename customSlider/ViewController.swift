//
//  ViewController.swift
//  customSlider
//
//  Created by Christophe Hoste on 04.02.18.
//  Copyright © 2018 Christophe Hoste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: Slider!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.delegate = self
    }
}

extension ViewController: SliderProtocol {
    func colorDidChange(color: UIColor) {
        nameLabel.textColor = color
    }
}

