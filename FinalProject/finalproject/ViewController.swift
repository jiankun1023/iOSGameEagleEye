//
//  ViewController.swift
//  FinalProject
//
//  Created by 陶健坤 on 16/2/26.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var infoView: UIImageView!
    var backLayer: UIView!
    var eagleView : UIImageView!
    let soundplayer = SoundController()
    var musicController: Bool = true
    var pressCount = 0
    
    
    // Music button
    @IBOutlet weak var musicButton: UIButton!
    
    // Three Game Button
    @IBAction func gameControlButton(sender: UIButton) {
        if musicController {
            soundplayer.playSoundEffect("buttonSound.wav", playtime: 0)
        }
    }
    
    @IBOutlet weak var eagle: UIImageView!
  
    @IBAction func infoViewAppear(sender: UIButton) {
        self.backLayer.center.y =  self.view.bounds.height * 1.5
        UIView.animateWithDuration(0.5, animations: {
            self.backLayer.center.y = self.view.center.y
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
        musicButton.addTarget(self, action: "pressed", forControlEvents: .TouchUpInside)
    }
    
    // If main view appear sound play
    override func viewWillAppear(animated: Bool) {
              if musicController {
            soundplayer.playSoundEffect("background.mp3", playtime: -1)
        }
    }
    
    func pressed() {
        if pressCount == 0 {
            musicController = false
            soundplayer.stopSoundEffect()
            let image = UIImage(named: "musicban")
            musicButton.setBackgroundImage(image, forState: .Normal)
            pressCount = 1
        } else if pressCount == 1 {
            musicController = true
            pressCount = 0
            let image = UIImage(named: "music")
            musicButton.setBackgroundImage(image, forState: .Normal)
            soundplayer.playSoundEffect("background.mp3", playtime: -1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showColorDetail" {
            let musicState = segue.destinationViewController as! colorGameViewController
            musicState.playOrNot = musicController
        } else if segue.identifier == "showLetterDetail" {
            let musicState = segue.destinationViewController as! letterGameViewController
            musicState.playOrNot = musicController
        } else if segue.identifier == "showNumberDetail" {
            let musicState = segue.destinationViewController as! numberGameViewController
            musicState.playOrNot = musicController
        }
    }
    
    
    // Info View
    func setupInfo(){
        //Set up UIView
        infoView = UIImageView(frame: CGRect(x: 62, y: 250, width: 250, height: 150))
        eagleView = UIImageView(frame: CGRect(x: 137, y: 159, width: 100, height: 100))
       
        //Set up background
        backLayer = UIView(frame: self.view.frame)
        
        let imageBac = UIImageView(frame: self.view.frame)
        
        //set background out of screen
        self.backLayer.center.y = -self.view.center.y
        backLayer.backgroundColor = UIColor.whiteColor()
        backLayer.alpha = 1
        
        imageBac.image = UIImage(named: "background2")
        eagleView.image = UIImage(named: "eagle")
        infoView.image = UIImage(named: "infoView")
        
        //set up button
        let button = UIButton(frame: CGRect(x: 160, y: 360, width: 50, height: 50))
        button.setBackgroundImage(UIImage(named: "acceptBtn"), forState: .Normal)
        button.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
        //add view
        self.view.addSubview(self.backLayer)
        self.backLayer.addSubview(imageBac)
        self.backLayer.addSubview(self.infoView)
        self.backLayer.addSubview(self.eagleView)
        self.backLayer.addSubview(button)
    }
    
    // dismiss the infoView
    func dismiss(){
        UIView.animateWithDuration(0.5, animations: {
            self.backLayer.center.y -= self.view.bounds.height
        })
    }

}

