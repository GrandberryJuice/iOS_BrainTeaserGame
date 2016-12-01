//
//  RestartGameVC.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 11/26/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop



class RestartGameVC: UIViewController {
    //Outlets and Variables
    @IBOutlet weak var pointLbl:UILabel!
    var pointHolder:GameVC!
    var points:Int!

    @IBOutlet weak var returnToMenuBtn: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //points = pointHolder.addPoints
        if (points) != nil {
            pointLbl.text = "\(Int(points))"
        }
        self.returnToMenuBtn.isUserInteractionEnabled = true
        self.returnToMenuBtn.layer.zPosition = 1
       
    }

    @IBAction func buttonpressed(_ sender: UIButton) {
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rotate"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rotate"), object: nil)
          

    }


}
