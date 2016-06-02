//
//  ViewController.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 5/25/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop

class StartGameVC: UIViewController {
    
    //Constraints
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!
    
    
    var animEngine: AnimationEngine!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [btnConstraint])
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen()
    }

}

