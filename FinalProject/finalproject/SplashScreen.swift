//
//  SplashScreen.swift
//  finalproject
//
//  Created by 陶健坤 on 16/3/13.
//  Copyright © 2016年 jiankun. All rights reserved.
//

import UIKit

// class for splash screen
class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the time of showing splash screen: 2s
        performSelector("showNavController", withObject: nil, afterDelay: 2)
    }
    
    func showNavController() {
        performSegueWithIdentifier("showMainScreen", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
