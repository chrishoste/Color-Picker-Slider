//
//  Slider.swift
//  customSlider
//
//  Created by Christophe Hoste on 04.02.18.
//  Copyright © 2018 Christophe Hoste. All rights reserved.
//

import UIKit

protocol SliderProtocol: class {
    func colorDidChange(color: UIColor)
}

@IBDesignable class Slider: View {
    
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var sliderView: UIView!
    
    weak var delegate: SliderProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup(xibName: "Slider")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup(xibName: "Slider")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        thumbView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tapGesture.numberOfTapsRequired = 1
        sliderView.addGestureRecognizer(tapGesture)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        thumbView.layer.cornerRadius = thumbView.frame.width / 2
        thumbView.center = CGPoint(x: thumbView.center.x, y: sliderView.frame.minY)
        sliderView.layer.cornerRadius = sliderView.frame.width / 2
        sliderView.clipsToBounds = true
        
        sliderView.setGradientRainbow()
    }
    
    @objc func panAction(_ gesture: UIPanGestureRecognizer) {
        
        let yTranslation = gesture.translation(in: self.view).y
        let newThumbY = thumbView.center.y + yTranslation
        
        if newThumbY < sliderView.frame.maxY && newThumbY > sliderView.frame.minY {
            thumbView.center = CGPoint(x: thumbView.center.x, y: newThumbY)
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            setColor(point: CGPoint(x: sliderView.center.x / 2, y: newThumbY))
        }
    }
    
    @objc func tapAction(_ gesture: UITapGestureRecognizer) {
        thumbView.center = CGPoint(x: thumbView.center.x, y: gesture.location(in: sliderView).y)
        setColor(point: gesture.location(in: sliderView))
    }
    
    func setColor(point: CGPoint) {
        let color: UIColor = sliderView.getColor(at: point)
        thumbView.backgroundColor = color
        
        delegate?.colorDidChange(color: color)
    }
}
