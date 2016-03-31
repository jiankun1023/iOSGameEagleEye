//
//  numberGamePlace.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/7.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit

class numberGamePlace: UIView {
 
    var buttonSet = [[UIButton]]()
    var gamelevel = 0
    var counter = 0 //repeat some level
    var currentGametime = 7
    var letterGameEval: String = "Try Again!"
    
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
        var numberSize: CGFloat
        var specialNumber: String
        var normalNumber: String
        let range = gamelevel + 1
        let xPos = Int(arc4random()) % range
        let yPos = Int(arc4random()) % range
        
        let letter = Int(arc4random()) % 4
        switch letter {
        case 0:
            specialNumber = "1"
            normalNumber = "I"
        case 1:
            specialNumber = "0"
            normalNumber = "O"
        case 2:
            specialNumber = "9"
            normalNumber = "6"
        case 3:
            specialNumber = "0"
            normalNumber = "8"
        default:
            specialNumber = "0"
            normalNumber = "8"
        }
        
        // different gamelevel, differernt front size
        switch gamelevel {
        case 1:
            numberSize = 190
        case 2:
            numberSize = 125
        case 3:
            numberSize = 90
        case 4:
            numberSize = 70
        case 5:
            numberSize = 60
        case 6:
            numberSize = 50
        case 7:
            numberSize = 45
        case 8:
            numberSize = 40
        case 9:
            numberSize = 35
        case 10:
            numberSize = 30
        default:
            numberSize = 25
        }
        
        
        // generate several buttons
        for i in 0...gamelevel {
            var rowButton = [UIButton]()
            for j in 0...gamelevel {
                let button = UIButton(frame: CGRect(x: 1, y: 1, width: self.bounds.width / CGFloat(gamelevel + 1) - 2, height: self.bounds.height / CGFloat(gamelevel + 1) - 2))
                if i == xPos && j == yPos {
                    title = specialNumber
                    button.addTarget(self, action: "update", forControlEvents: .TouchUpInside)
                } else {
                    title = normalNumber
                }
                button.setTitle(title, forState: .Normal)
                button.titleLabel?.font = UIFont(name: "Hiragino Sans", size: numberSize)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                addSubview(button)
                rowButton += [button]
            }
            buttonSet.append(rowButton)
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
    func update(){
        
        NSLog("Button Pressed, Have choosed the corret button")
        
        for rowButton in buttonSet {
            for button in rowButton {
                button.removeFromSuperview()
            }
        }
        buttonSet.removeAll()
        letterGameEval = ""
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
                buttonSet[i][j].frame = buttonFrame
            }
        }
    }
    
    
}
