//
//  ViewController.swift
//  Canvas
//
//  Created by Oranuch on 3/10/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var trayView: UIView!
    // when it's moving up
    var trayCenterWhenOpen: CGPoint!
    // when it's moving down
    var trayCenterWhenClosed: CGPoint!
    
    let bottomFrameCoord = UIWindow(frame: UIScreen.mainScreen().bounds).frame.height
    var trayViewOpenPosition: CGFloat!
    var trayViewClosePosition: CGFloat!
    var isTrayViewOpen: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        trayViewOpenPosition = bottomFrameCoord - trayView.frame.height
        trayViewClosePosition = self.bottomFrameCoord - 40
        isTrayViewOpen = true
    }

    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        // Absolute (x,y) coordinates in parent view's coordinate system
        let point = panGestureRecognizer.locationInView(view)
        
        // Total translation (x,y) over time in parent view's coordinate system
        let translation = panGestureRecognizer.translationInView(view)
        var trayOriginalCenter: CGPoint!
        trayOriginalCenter = trayView.center
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
            // if moving down
            if panGestureRecognizer.velocityInView(trayView).y > 0 {
                trayCenterWhenClosed = trayView.center
                UIView.animateWithDuration(0.4, animations: {
                    self.trayView.frame.origin.y = self.trayViewClosePosition
                })
                isTrayViewOpen = false
            }
                
            // if moving up
            else {
                trayCenterWhenOpen = trayView.center
                UIView.animateWithDuration(0.4, animations: {
                    self.trayView.frame.origin.y = self.trayViewOpenPosition
                })
                isTrayViewOpen = true
            }

            

        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
        }
    }
    
    @IBAction func onTrayTapGesture(sender: AnyObject) {
        if isTrayViewOpen == true {
            self.trayView.frame.origin.y = self.trayViewClosePosition
            isTrayViewOpen = false
        } else {
            self.trayView.frame.origin.y = self.trayViewOpenPosition
            isTrayViewOpen = true
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

