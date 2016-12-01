//
//  ViewController.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 5/25/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop
import AVFoundation

class StartGameVC: UIViewController {
    
    //Constraints
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!
    @IBOutlet weak var outsideBrain: UIImageView!
    @IBOutlet weak var letsPlayConstraints: NSLayoutConstraint!
    @IBOutlet weak var optionsConstraints: NSLayoutConstraint!
    static var audioPlayer = AVAudioPlayer()
    static var start = StartGameVC()
    
    var animEngine: AnimationEngine!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animEngine = AnimationEngine(constraints: [letsPlayConstraints, optionsConstraints])
      
        do {
            //var audioPlayer = AVAudioPlayer()
            StartGameVC.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"Platformer2", ofType:"mp3")!))
            //audioPlayer.delegate = self
            StartGameVC.audioPlayer.prepareToPlay()
            StartGameVC.audioPlayer.play()
        } catch {
            print("cant load file")
        }
        
       // NotificationCenter.default.addObserver(self, selector: #selector(StartGameVC.rotateCircle(notification:)), name: NSNotification.Name(rawValue: "rotate"), object: nil)
    }
   

    
    
    override func viewDidAppear(_ animated: Bool) {
        self.animEngine.animateOnScreen()
        rotateImage()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
        
    }
    
    func rotateImage() {
        UIView.animate(withDuration: 1.0, delay:0, options:[.repeat, .autoreverse], animations:{
            self.outsideBrain.transform = CGAffineTransform(rotationAngle: 360)
        }, completion: nil)
    }
    
    @IBAction func unwindToMainMenu(unwind:UIStoryboardSegue) {
//        var layer = outsideBrain.layer.presentation()! as CALayer
//        var frame = layer.frame
//        
//        outsideBrain.layer.removeAllAnimations()
//        outsideBrain.frame = frame
        DispatchQueue.main.async {
            self.rotateImage()
        }
        
    }
    
    func rotateCircle(notification:NSNotification) {
        UIView.animate(withDuration: 1.0, delay:0, options:[.repeat, .autoreverse], animations:{
            self.outsideBrain.transform = CGAffineTransform(rotationAngle: 360)
        }, completion: nil)
    }
}

