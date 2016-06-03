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
    var counter = 60
    var timer = NSTimer()
    var lastCard:Card!
    var addPoints = 0
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }
    
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            cardState()
            yesToAnswer()
 //            checkAnswer()
        } else {
            titleLbl.text = "Does this card match the previous?"
        }
        showNextCard(sender)
    }
    
    @IBAction func noPressed(sender: AnyObject) {
       
        cardState()
        noToAnswer()
//        checkAnswer()
        showNextCard(sender as! UIButton)
   
    }
    
    func showNextCard(sender:UIButton) {
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
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (
                anim:POPAnimation!, finished:Bool) -> Void in
            })
        }
    }
    
    func createCardFromNib() -> Card? {
       return  NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil) [0] as? Card
    }
    
    
//    func checkAnswer() {
//        print(lastCard.currentShape)
//        print(currentCard.currentShape)
//        if lastCard.currentShape == currentCard.currentShape {
//            addPoints += 1
//            //POPUP Green checkmark
//            print("correct!")
//        } else {
//            //POPUP Red checkmark
//            print("wrong!")
//        }
//    }
    
    func yesToAnswer() {
        if lastCard.currentShape == currentCard.currentShape {
            addPoints += 1
            correctImg.hidden = false
            delay(1.0) {
                self.correctImg.hidden = true
            }
            //print("correct")
        } else {
            wrongImg.hidden = false
            delay(1.0) {
                self.wrongImg.hidden = true
            }
            print("wrong")
        }
    }
    
    func noToAnswer() {
        if lastCard.currentShape != currentCard.currentShape {
            addPoints += 1
            correctImg.hidden = false
            delay(1.0) {
                self.correctImg.hidden = true
            }

            //print("correct")
        } else {
            wrongImg.hidden = false
            delay(1.0) {
                self.wrongImg.hidden = true
            }
            //print("wrong")
        }
    }
    
    
    func timerAction() {
        repeat {
            counter -= 1
            if counter > 9 {
                timerLbl.text = "0:\(counter)"
            } else {
                timerLbl.text = "0:0\(counter)"
            }
        } while counter < 0
    }
    
    func cardState() {
        if lastCard == nil {
            lastCard = currentCard
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    
}
