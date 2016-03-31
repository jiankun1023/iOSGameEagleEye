//
//  letterGameViewController.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/7.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit

// game controller
class letterGameViewController: UIViewController {

    @IBOutlet weak var lodingView: UIImageView!
    @IBOutlet weak var letterGamePlace: LetterGamePlace!
    
    var timer = NSTimer()  // timer
    var currentTime = Int() // timer
    let gameSound = SoundController() //play sound
    var playOrNot: Bool = true // sound controller
    var currentEvaluation : String = "Try Again!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if playOrNot {
            gameSound.playSoundEffect("gameSound.mp3", playtime: -1)
        }

        lodingView.image  = UIImage(named: "1")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    

    /// MARK: Timer funciton
    func updateTime() {
        currentEvaluation = letterGamePlace.getEvaluation()
        currentTime = letterGamePlace.timeElapse()
        
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
        
        // alert controller
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
