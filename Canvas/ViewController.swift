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
    
    var newlyCreatedFace: UIImageView!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var deadFaceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        trayViewOpenPosition = bottomFrameCoord - trayView.frame.height
        trayViewClosePosition = self.bottomFrameCoord - 40
        isTrayViewOpen = true
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onImagePanGesture:")
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
    
    @IBAction func onImagePanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(view)
        
        // Total translation (x,y) over time in parent view's coordinate system
        let translation = panGestureRecognizer.translationInView(view)
        var faceOriginalCenter: CGPoint!
        faceOriginalCenter = panGestureRecognizer.view?.center
        var initialCenter = faceOriginalCenter
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)

            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y -= trayView.center.y
            print("Gesture began at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            // ****** FIX THIS *****
            newlyCreatedFace.center = CGPoint(x: initialCenter.x + translation.x, y: trayView.center.y + translation.y )
            print("Gesture changed at: \(point)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var initialCenter: CGPoint!
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            initialCenter = (panGestureRecognizer.view?.center)!
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
        newlyCreatedFace.center = CGPoint( x: initialCenter.x + translation.x, y: translation.y )

        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {

    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

