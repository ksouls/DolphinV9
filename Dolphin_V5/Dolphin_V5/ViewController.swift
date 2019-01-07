
//
//  ViewController.swift
//  Dolphin_V5
//
//  Created by an16aal on 14/12/2018.
//  Copyright © 2018 CSStestuser. All rights reserved.
//

import UIKit

protocol subviewDelegate{
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate {
    
    //let when = DispatchTime.now() + 2
    // DispatchQueue.main.asyncAfter(deadline: when)
    //{
    //Your code for actions when the time is up
    //}
    
    func changeSomething(){
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect:dolphin.frame))
           addScore()
    }
    //score
    var gameScore = 0
    
    // screen fit
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    //behaviours and animators
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicBehaviour: UIDynamicItemBehavior!
    var collisionBehaviour: UICollisionBehavior!
    var gravityBehaviour: UIGravityBehavior!

    //In-game links
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var dolphin: drag!
    
    //end game links
    
    // loops
    let missileArray = [0,2,4,6,8,10,12,14,16,18]
    let ringArray = [0,2,4,6,8,10,12,14,16,18]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dolphin.delegate = self
        
        dynamicAnimator = UIDynamicAnimator(referenceView : self.view)
        dynamicBehaviour = UIDynamicItemBehavior(items [])
        dynamicAnimator.addBehavior(dynamicBehaviour)
        dynamicBehaviour = UICollisionBehavior(items [])
        dynamicAnimator.addBehavior(collisionBehaviour)
        gravityBehaviour = UIGravityBehavior(items [])
        
        //Game Over Screen View
        
        
        // background
        var backgroundArray: [UIImage]!
        backgroundArray = [UIImage(named: "Background_1")!,
                           UIImage(named: "Background_2")!,
                           UIImage(named: "Background_3")!,
                           UIImage(named: "Background_4")!,
                           UIImage(named: "Background_5")!,
                           UIImage(named: "Background_6")!,
                           UIImage(named: "Background_7")!,
                           UIImage(named: "Background_8")!,
                           UIImage(named: "Background_9")!,
                           UIImage(named: "Background_10")!,
                           UIImage(named: "Background_9")!,
                           UIImage(named: "Background_8")!,
                           UIImage(named: "Background_7")!,
                           UIImage(named: "Background_6")!,
                           UIImage(named: "Background_5")!,
                           UIImage(named: "Background_4")!,
                           UIImage(named: "Background_3")!,
                           UIImage(named: "Background_2")!,
                           UIImage(named: "Background_1")!]
        
        background.image = UIImage.animatedImage(with: backgroundArray, duration: 2)
        background.frame = CGRect(x:0, y:0, width: W*1, height: H*1)
        
        //dolphin
        var dolphinArray: [UIImage]!
        
        dolphinArray = [UIImage(named: "Dolphin_1.gif")!,
                      UIImage(named: "Dolphin_2.gif")!,
                      UIImage(named: "Dolphin_3.gif")!,
                      UIImage(named: "Dolphin_4.gif")!,
                      UIImage(named: "Dolphin_5.gif")!,
                      UIImage(named: "Dolphin_6.gif")!]
        
        dolphin.image = UIImage.animatedImage(with: dolphinArray, duration: 0.5)
        dolphin.frame = CGRect(x:0, y: H*(0.33), width: W*(0.16), height: H*(0.12))
        
        //missile
        for index in 0...9{
            let delay = Double (self.missileArray [index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
        
        let missileImage = UIImageView(image: nil)
        var missileArray: [UIImage]!
        missileArray = [UIImage(named: "Missile_2.gif")!,
                        UIImage(named: "Missile_3.gif")!]
        
        missileImage.image = UIImage.animatedImage(with: missileArray, duration: 1.5)
        missileImage.frame = CGRect (x: self.W, y: CGFloat(arc4random_uniform(UInt32(self.H)-50)), width: self.W*(0.09), height: self.H(0.09))
        
            self.view.addSubview(missileImage)
            self.view.bringSubview(toFront: missileImage)
            self.dynamicBehaviour.addItem(missileImage)
            //missile speed
            self.dynamicBehaviour.addLinearVelocity(CGPoint(x: -200, y:0), for: missileImage)
            self.collisionBehaviour.addItem(missileImage)
        }
        //rings
        for index in 0 ... 9{
            let delay = Double (self.ringArray [index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release)
            {
         let ringImage = UIImageView(image: nil)
         var ringArray: [UIImage]!
         
         ringArray = [UIImage(named: "Ring_1")!,
                      UIImage(named: "Ring_2")!,
                      UIImage(named: "Ring_3")!,
                      UIImage(named: "Ring_4")!,
                      UIImage(named: "Ring_5")!,
                      UIImage(named: "Ring_6")!]
                
        ringImage.image = UIImage.animatedImage(with: ringArray, duration: 1.5)
        ringImage.frame = CGRect (x: self.W, y: CGFloat(arc4random_uniform(UInt32(self.H)-50)), width: self.W*(0.1), height: self.H(0.1))
        
        self.view.addSubview(ringImage)
        self.view.bringSubview(toFront: ringImage)
        self.dynamicBehaviour.addItem(ringImage)
        //ring speed
        self.dynamicBehaviour.addLinearVelocity(CGPoint(x: -300, y:0), for: ringImage)
        self.collisionBehaviour.addItem(ringImage)
        //magic: coin disappears
        self.collisionBehaviour.action =
            {
                if ringImage.frame.intersects(self.dolphin.frame){
                ringImage.removeFromSuperview()
                }
              }
            }
        }
        //20 second timer
            let timer = DispatchTime.now()+3
            DispatchQueue.main.asyncAfter(deadline: timer){
                self.gameOverScreen.alpha = 1
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

