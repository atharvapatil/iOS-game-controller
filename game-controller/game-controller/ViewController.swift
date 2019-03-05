//
//  ViewController.swift
//  game-controller
//
//  Created by Atharva Patil on 04/03/2019.
//  Copyright © 2019 Atharva Patil. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let flip = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
         flip.gyroUpdateInterval = 0.2
        
        flip.startGyroUpdates(to: OperationQueue.current! ){ (data, error) in
            if let myData = data
            {
                print(myData.rotationRate.x*10)
            }
        }
        
    }
    
 

}

