//
//  GameVC.swift
//  BrainTeaser
//
//  Created by KENNETH GRANDBERRY on 5/31/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl:UILabel!
    @IBOutlet weak var correctImg:UIImageView!
    @IBOutlet weak var wrongImg:UIImageView!
    
    //variables
    var currentCard: Card!
    var counter = 30
    var timer = Timer()
    var lastCard:Card!
    var addPoints = 0
    //var restartGameVC:RestartGameVC!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }
    
  
    
    @IBAction func yesPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            cardState()
            yesToAnswer()
 
        } else {
            titleLbl.text = "Does this card match the first card?"
        }
        showNextCard(sender)
    }
    
    @IBAction func noPressed(_ sender: AnyObject) {
        cardState()
        noToAnswer()
        showNextCard(sender as! UIButton)
   
    }
    
    func showNextCard(_ sender:UIButton) {
        if let current = currentCard {
            let cardToRemove = currentCard

            if sender.titleLabel?.text == "START" {
                if lastCard.currentShape == currentCard.currentShape {
                    lastCard = nil
                }
            } else {
                cardState()
            }
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove!, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation?, finished:Bool) in
                cardToRemove?.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.isHidden {
                noBtn.isHidden = false
                yesBtn.setTitle("YES", for: UIControlState())
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation?, finished:Bool) in
                //code
            })
        }
    }
    
    func createCardFromNib() -> Card? {
       return  Bundle.main.loadNibNamed("Card", owner: self, options: nil)? [0] as? Card
    }
    
    
    
    func yesToAnswer() {
        if lastCard.currentShape == currentCard.currentShape {
            addPoints += 1
            correctImg.isHidden = false
            delay(1.0) {
                self.correctImg.isHidden = true
            }
            //print("correct")
        } else {
            wrongImg.isHidden = false
            delay(1.0) {
                self.wrongImg.isHidden = true
            }
            print("wrong")
        }
    }
    
    func noToAnswer() {
        if lastCard.currentShape != currentCard.currentShape {
            addPoints += 1
            correctImg.isHidden = false
            delay(1.0) {
                self.correctImg.isHidden = true
            }
        } else {
            wrongImg.isHidden = false
            delay(1.0) {
                self.wrongImg.isHidden = true
            }
        }
    }
    
    
    func timerAction() {
            counter -= 1
            if counter > 9 {
                timerLbl.text = "0:\(counter)"
            } else {
                timerLbl.text = "0:0\(counter)"
            }
        if counter == 0 {
            currentCard.removeFromSuperview()
            performSegue(withIdentifier: "RestartGameVC", sender: addPoints)
            
        }
        
    }
    
    func cardState() {
        if lastCard == nil {
            lastCard = currentCard
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestartGameVC" {
            if let restartGameVC = segue.destination as? RestartGameVC {
                if let points =  sender as? Int {
                    restartGameVC.points = points
                }
            }
        }
    }
}
