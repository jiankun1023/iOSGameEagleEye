//
//  colorGameViewController.swift
//  finalproject
//
//  Created by Jiankun Tao on 2/27/16.
//  Copyright © 2016 jiankun. All rights reserved.
//

import UIKit

// game controller
class colorGameViewController: UIViewController {
    
    @IBOutlet weak var lodingImage: UIImageView!
    @IBOutlet weak var gamePlace: GamePlace! //space for generate block
    
    var timer = NSTimer()
    var currentGameTime =  Int()
    let gameSound = SoundController()
    var playOrNot: Bool = true
    var currentEvaluation: String = "Try Again!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start Music
        if playOrNot {
            gameSound.playSoundEffect("gameSound.mp3", playtime: -1)
        }
        // Basic Image
        lodingImage.image = UIImage(named: "1")
        // Timer
        currentGameTime = gamePlace.colorGameTimer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }

    // MARK: Timer function
    func updateTime(){
        currentGameTime = gamePlace.timeEla()
        currentEvaluation = gamePlace.getEvaluation()
        let lodingImageNumber = 12 - currentGameTime
        lodingImage.image = UIImage(named: "\(lodingImageNumber)")
        
         NSLog("\(currentGameTime)")
        if currentGameTime == 0 {
            let alertController = UIAlertController(title: "Game Over", message: "\(currentEvaluation)", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            timer.invalidate()
            if playOrNot {
                gameSound.stopSoundEffect()
                gameSound.playSoundEffect("end.mp3", playtime: 0)
            }

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
