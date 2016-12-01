//
//  TestViewController.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 11/28/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var OuterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateImage()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func rotateImage() {
        
        UIView.animate(withDuration: 1.0, delay:0, options:[.repeat, .autoreverse], animations:{
                self.OuterImage.transform = CGAffineTransform(rotationAngle: 360)
            }, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
