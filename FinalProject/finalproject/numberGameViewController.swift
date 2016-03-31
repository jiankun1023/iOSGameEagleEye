//
//  numberGameViewController.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/7.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit

// game controller
class numberGameViewController: UIViewController {
    
    @IBOutlet weak var lodingView: UIImageView!
    @IBOutlet weak var numberGame: numberGamePlace!
    
    var currentEvaluation: String = "Try Again!"
    var currentTime = Int()  // timer
    let gameSound = SoundController() // sound function
    var playOrNot: Bool = true // sound controller
    var timer = NSTimer() // timer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if playOrNot {
            gameSound.playSoundEffect("gameSound.mp3", playtime: -1)
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
     /// MARK: Timer funciton
    func updateTime() {
        currentEvaluation = numberGame.getEvaluation()
        currentTime = numberGame.timeElapse()
        
        // picture of loding bar
        let picNum : Int
        switch currentTime {
        case 6:
            picNum = 1
        case 5:
            picNum = 3
        case 4:
            picNum = 5
        case 3:
            picNum = 7
        case 2:
            picNum = 9
        case 1:
            picNum = 11
        case 0:
            picNum = 12
        default:
            picNum = -1
        }
        
        lodingView.image = UIImage(named: "\(picNum)")
        NSLog("\(currentTime)")
        if currentTime == 0 {
            let alertController = UIAlertController(title: "Game Over", message: "\(currentEvaluation)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            timer.invalidate()
            
            if playOrNot {
                gameSound.stopSoundEffect()
                gameSound.playSoundEffect("end.mp3", playtime: 0)
            }
        }
    }
}
