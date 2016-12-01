//
//  OptionsVC.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 11/29/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import AVFoundation

class OptionsVC: UIViewController {
    
    
    //var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
         //audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"Platformer2", ofType:"mp3")!))
        //audioPlayer.prepareToPlay()
        } catch {
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true) {
            StartGameVC.audioPlayer.play()
        } else {
            StartGameVC.audioPlayer.stop()
        }
    }

    @IBAction func mainMenuBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
