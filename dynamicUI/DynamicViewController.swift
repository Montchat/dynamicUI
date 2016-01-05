//
//  ViewController.swift
//  dynamicUI
//
//  Created by Joe E. on 1/3/16.
//  Copyright © 2016 Joe E. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {
    
    //MARK: Properties
    //setting up our sceneWithGravity
    var animator:UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()

    //MARK: @IBOutlets
    @IBOutlet weak var greenCircle: UIView!
    @IBOutlet weak var redCircle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRound(greenCircle)
        makeRound(redCircle)
        
        createAnimationEffects()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension DynamicViewController {
    func makeRound(view:UIView) {
        view.layer.cornerRadius = view.frame.width / 2
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInView(view)
            createRandomViews(location.x, y: location.y)
        }
        
    }
    
    func createAnimationEffects() {
        animator = UIDynamicAnimator(referenceView: view)
        
        //adding our views to be processed by gravity.
        gravity.addItem(greenCircle)
        gravity.addItem(redCircle)
        
        //adding the gravity process to our animator...so that the viewController updates what is happening
        animator?.addBehavior(gravity)
        
        //adding the views to the collision behaviors so they collide with each other
        collisionBehavior.addItem(greenCircle)
        collisionBehavior.addItem(redCircle)
        
        //turning the boundaries into boundaries
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        //adding collisionBehavior to the animator
        animator?.addBehavior(collisionBehavior)
        
    }
    
    func createRandomViews(x:CGFloat, y:CGFloat) {
        let size:CGFloat = 40
        let view = UIView(frame: CGRect(x: x, y: y, width: size, height: size))
        view.backgroundColor = getRandomColor(0.66)
        self.view.addSubview(view)
        
    }
    
    func getRandomColor(alpha: CGFloat) -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        
        //convert the UIColor to CGColor
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
}