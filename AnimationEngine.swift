//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 5/31/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPoint(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints:[NSLayoutConstraint]) {
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        self.constraints = constraints
    }
    
    func animateOnScreen() {
        
        var index = 0
        repeat {
            let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            moveAnim?.toValue = self.originalConstants[index]
            moveAnim?.springBounciness = 12
            moveAnim?.springSpeed = 12
            
            let con = self.constraints[index]
            con.pop_add(moveAnim, forKey: "moveOnScreen")
            
            index += 1
            
        } while (index < self.constraints.count)
    }
    
    class func animateToPosition(_ view:UIView, position:CGPoint, completion: @escaping ((POPAnimation?, Bool) ->Void)) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim?.toValue = NSValue(cgPoint: position)
        moveAnim?.springBounciness = 8
        moveAnim?.springSpeed = 8
        moveAnim?.completionBlock = completion
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
 }
