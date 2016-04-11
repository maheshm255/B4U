//
//  b4u-OrderStatusView.swift
//  bro4u
//
//  Created by Mac on 10/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class b4u_OrderStatusView: UIView {


    let π:CGFloat = CGFloat(M_PI)
    var carPercent:CGFloat = 1.0

    var orderStatus:Int = -1

    @IBInspectable var counterColor: UIColor = UIColor.lightGrayColor()

    
    override func drawRect(rect: CGRect) {
        // Drawing cod
        
        self.createCarPlaceHolder()
        
        
        let carStartAngel: CGFloat = 3*π/2
        var carEndAngle: CGFloat =  3*π/2
        
        
        switch orderStatus
        {
        case 1 :
          carEndAngle = π
        case 2 :
            carEndAngle = π/2
        case 3 :
            carEndAngle = 0
        case 4 :
            carEndAngle = -2 * π/2
        default:
            carEndAngle = 3*π/2
        }
        // 1 = π
        
        // 2 = π/2
        
        // 3 = 0
        
        // 4 = -2 * π/2
        // Car
        let carEndAngelCal = (carStartAngel - carEndAngle) * (carPercent / 100.0) + carStartAngel
        self.drawCarPie(carStartAngel, endAngle:carEndAngelCal, canvasRect:rect)
        
      
    }
    

    
    func createCarPlaceHolder()
    {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = 70
        
        let arcWidth: CGFloat = 15
        
        let startAngle: CGFloat = 0
        let endAngle: CGFloat =  2*π
        
        let path = UIBezierPath(arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
    }
    
    func drawCarPie(startAngle:CGFloat , endAngle:CGFloat ,canvasRect:CGRect)
    {
        let carBezierPath3 = UIBezierPath()
        
        carBezierPath3.addArcWithCenter(CGPointMake(canvasRect.size.width / 2, canvasRect.size.height / 2), radius:70 , startAngle:startAngle, endAngle:endAngle,  clockwise:true)
        
        
        // carBezierPath.closePath()
        
        carBezierPath3.lineWidth = 15;
        
        UIColor(red:90.0/255.0, green:178.0/255.0, blue:49.0/255.0, alpha:1.0).setStroke()
        carBezierPath3.stroke()
    }

}
