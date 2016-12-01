//
//  Card.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 6/1/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class Card: UIView {
    
    let shapes = ["shape1","shape2", "shape3"]
    var currentShape: String!
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    override func awakeFromNib() {
        setUpView()
        selectShape()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157/255.0, green: 157/255.0, blue: 157/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(3))]
        shapeImage.image = UIImage(named:currentShape)
    }
}
