//
//  CircularGraph.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

@IBDesignable
class CircularGraph: UIView {
    let trackLayer: CAShapeLayer = CAShapeLayer()
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    
    var radius: CGFloat = 310/2
    var startAngle: CGFloat = 0
    var endAngle: CGFloat = 2 * CGFloat.pi
    
    var percentage: CGFloat{
        set(newValue){
            shapeLayer.strokeEnd = newValue
        }
        get{
            return shapeLayer.strokeEnd
        }
    }
    func endPoint() -> CGPoint {
        /*
         to get coordinate from angle of circle
         https://www.mathsisfun.com/polar-cartesian-coordinates.html
         */
        
        let x = self.radius * cos(self.endAngle) // cos(α) = x / radius
        let y = self.radius * sin(self.endAngle) // sin(α) = y / radius
        let point = CGPoint(x: x, y: y)
        
        return point
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircularGraph(view: self, percentage: 1.0)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCircularGraph(view: self, percentage: 1.0)
    }
    
    func setupCircularGraph(view: UIView, percentage: CGFloat){
        
        var lineWidth: CGFloat = 3
        var center: CGPoint = view.center
        
        
        var circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = center

        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(displayP3Red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0).cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapSquare
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        shapeLayer.strokeEnd = percentage
        view.layer.addSublayer(shapeLayer)
        
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
