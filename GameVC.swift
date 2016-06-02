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
    
    //variables
    var currentCard: Card!
    var counter = 60
    var timer = NSTimer()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
       
    }
    
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer()
        } else {
            titleLbl.text = "Does this card match the previous?"
        }
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer()
        showNextCard()
    }
    
    func showNextCard() {
        if let current = currentCard {
            let cardToRemove = currentCard
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
    
    
    func checkAnswer() {
        
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
}
