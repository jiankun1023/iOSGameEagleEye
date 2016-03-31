//
//  GamePlace.swift
//  finalproject
//
//  Created by 陶健坤 on 16/2/28.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit


class GamePlace: UIView {
    
    var colorGameTimer = 12
    var gameButton = [[UIButton]]() //button set
    var gamelevel = 0  //store the level
    ///R,G,B value
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var counter = 0 //repeat some level
    var evaluation: String = "Try Again!"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        gamelevel = 1
        blockGenerator(10)
    }
    
    ///
    /// Use this function to generate block in differernt level
    ///MARK: Generate Block
    func blockGenerator(radius: CGFloat){
        let randomRed = CGFloat(arc4random() % 256) // Random number for Red
        let randomGreen = CGFloat(arc4random() % 256) // Random number for Green
        let randomBlue = CGFloat(arc4random() % 256) // Random number for Blue
        let brightOrDark = arc4random() % 2 // the special block's bright
        let range = gamelevel + 1
        let xPos = Int(arc4random()) % range // special block's x coordinate
        let yPos = Int(arc4random()) % range// special block's y coordinate
        
         // generate several buttons
        for i in 0...gamelevel{
            var rowbutton = [UIButton]()
            for j in 0...gamelevel{
                let button = UIButton(frame: CGRect(x: 1, y: 1, width: self.bounds.width / CGFloat(gamelevel + 1) - 2, height: self.bounds.height / CGFloat(gamelevel + 1) - 2))
                
                let colorChange: CGFloat
                // set level num
                if gamelevel <= 3 {
                    colorChange = 40
                } else if gamelevel <= 5 {
                    colorChange = 25
                } else if gamelevel <= 7 {
                    colorChange = 16
                } else if gamelevel <= 12{
                    colorChange = 12
                } else{
                    colorChange = 8
                }
            
                
                if i == xPos && j == yPos {
                    if (brightOrDark == 0){
                        red = (randomRed - colorChange)/255
                        green = (randomGreen - colorChange)/255
                        blue = (randomBlue - colorChange)/255
                    } else if (brightOrDark == 1) {
                        red = (randomRed + colorChange)/255
                        green = (randomGreen + colorChange)/255
                        blue = (randomBlue + colorChange)/255
                    }
                    button.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
                }else{
                    red  = randomRed/255
                    green = randomGreen/255
                    blue = randomBlue/255
                }
               
                button.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
                
                
                button.layer.cornerRadius = radius
                addSubview(button)
                rowbutton += [button]
                
            }
            gameButton.append(rowbutton)
        }
    }
    
    /// Set the time for each game level
    /// MARK: Timer
    func timeEla() -> Int{
        colorGameTimer--
        return colorGameTimer
    }
    
    /// this function return the evaluation of the gamelevel
    func getEvaluation() -> String {
        return evaluation
    }
    
    ///
    ///When user click the correct one, remove all button and go to next level
    ///MARK: Button Action
    func pressed(sender: UIButton!){
        NSLog("Button Pressed, Have choosed the corret button")
    
        for rowButton in gameButton {
            for button in rowButton {
                button.removeFromSuperview()
            }
        }
        gameButton.removeAll()
        
        colorGameTimer = 12
        
        //check evaluation
        if gamelevel < 4 {
            evaluation = "Normal"
        } else if gamelevel < 7 {
            evaluation = "Median"
        }else if gamelevel <= 12 {
            evaluation = "Great"
        } else{
            evaluation = "Eagle Eye"
        }
        
        if gamelevel == 3{
                if counter == 0 {
                counter++
                blockGenerator(6)
            } else {
                counter = 0
                gamelevel++
                blockGenerator(6)
            }
        }else if gamelevel == 4{
            if counter == 0 {
                counter++
                blockGenerator(6)
            } else {
                counter = 0
                gamelevel++
                blockGenerator(6)
            }
        }else if gamelevel == 7 {
            if counter == 0 {
                counter++
                blockGenerator(6)
            } else {
                counter = 0
                gamelevel++
                blockGenerator(6)
            }
        }else if gamelevel <= 12{
            gamelevel++
            blockGenerator(6)
        }else {
            blockGenerator(5)
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
                gameButton[i][j].frame = buttonFrame
            }
        }
    }
    
    

 
    
}
