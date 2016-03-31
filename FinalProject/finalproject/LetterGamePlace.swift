//
//  LetterGamePlace.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/2.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit

class LetterGamePlace: UIView {
    
    var letterButton = [[UIButton]]()
    var gamelevel = 0
    var counter = 0 //repeat some level
    var currentGametime = 7
    var letterGameEval = "Try Again!"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gamelevel = 1
        blockGenerator()
    }
    
    ///
    /// Use this function to generate block in differernt level
    /// MARK: Generate Block
    func blockGenerator(){
        var title: String
        let range = gamelevel + 1
        let xPos = Int(arc4random()) % range
        let yPos = Int(arc4random()) % range
        let letterSize: CGFloat
        let specialLetter: String
        let normalLetter: String
        
        let letter = Int(arc4random()) % 4
        switch letter {
        case 0:
            specialLetter = "F"
            normalLetter = "E"
        case 1:
            specialLetter = "O"
            normalLetter = "C"
        case 2:
            specialLetter = "W"
            normalLetter = "M"
        case 3:
            specialLetter = "P"
            normalLetter = "R"
        default:
            specialLetter = "P"
            normalLetter = "R"
        }
        
        // differernt game level, differernt front size
        NSLog("\(gamelevel)")
        switch gamelevel {
        case 1:
            letterSize = 190
        case 2:
            letterSize = 125
        case 3:
            letterSize = 90
        case 4:
            letterSize = 70
        case 5:
            letterSize = 60
        case 6:
            letterSize = 50
        case 7:
            letterSize = 45
        case 8:
            letterSize = 40
        case 9:
            letterSize = 35
        case 10:
            letterSize = 30
        default:
            letterSize = 25
        }
        
        // generate several buttons
        for i in 0...gamelevel {
            var rowbutton = [UIButton]()
            for j in 0...gamelevel {
                let button = UIButton(frame: CGRect(x: 1, y: 1, width: self.bounds.width / CGFloat(gamelevel + 1) - 2, height: self.bounds.height / CGFloat(gamelevel + 1) - 2))
                if i == xPos && j == yPos{
                    title = specialLetter
                    button.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
                } else {
                    title = normalLetter
                }
                
                button.setTitle(title, forState: .Normal)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                if letterSize != -1{
                    button.titleLabel?.font = UIFont(name: "Hiragino Sans", size: letterSize)
                }
                button.titleLabel?.adjustsFontSizeToFitWidth = true
                addSubview(button)
                rowbutton += [button]
            }
            letterButton.append(rowbutton)
        }
    }
    
    /// Set the time for each game level
    /// MARK: Timer
    func timeElapse() ->Int{
        currentGametime--
        return currentGametime
    }
    
    /// this function return the evaluation of the gamelevel
    func getEvaluation() ->String {
        return letterGameEval
    }
    
    ///
    ///When user click the correct one, remove all button and go to next level
    ///MARK: Button Action
    func pressed(sender: UIButton!){
        
         NSLog("Button Pressed, Have choosed the corret button")
        
        // after press, first clear all elements exist in screen
        for rowButton in letterButton {
            for button in rowButton {
                button.removeFromSuperview()
            }
        }
        letterButton.removeAll()
        letterGameEval = ""
        
        // each game level's default time
        currentGametime = 7
        
        //check evaluation
        if gamelevel < 5 {
            letterGameEval = "Normal"
        } else if gamelevel < 8 {
            letterGameEval = "Median"
        }else if gamelevel < 14 {
            letterGameEval = "Great"
        } else{
            letterGameEval = "Eagle Eye"
        }
        
        // generate block for each level
        if gamelevel == 3{
           
            if counter == 0 {
                counter++
                blockGenerator()
            } else {
                counter = 0
                gamelevel++
                blockGenerator()
            }
        }else if gamelevel == 4{
          
            if counter == 0 {
                counter++
                blockGenerator()
            } else {
                counter = 0
                gamelevel++
                blockGenerator()
            }
        }else if gamelevel == 7 {
            if counter == 0 {
                counter++
                blockGenerator()
            } else {
                counter = 0
                gamelevel++
                blockGenerator()
            }
        }else if gamelevel <= 14{
            gamelevel++
            blockGenerator()
        }else {
            blockGenerator()
        }
    }
    
    ///
    /// if addSubview, layoutSubview will be called
    /// MARK: Update UIView
    override func layoutSubviews() {
        
        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height
        
        var buttonFrame = CGRect(x: 1, y: 1, width: self.bounds.width / CGFloat(gamelevel + 1) - 2, height: self.bounds.height / CGFloat(gamelevel + 1) - 2)
        
        for i in 0...gamelevel{
            let rowX = (Float(viewWidth) / Float(gamelevel + 1)) * Float(i) + 1
            for j in 0...gamelevel{
                let rowY = (Float(viewHeight) / Float(gamelevel + 1)) * Float(j) + 1
                buttonFrame.origin.x = CGFloat(rowX)
                buttonFrame.origin.y = CGFloat(rowY)
                letterButton[i][j].frame = buttonFrame
            }
        }
    }
    
    
}
