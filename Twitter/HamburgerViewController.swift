//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
 
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var originalLeftMargin: CGFloat!
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            UIView.animate(withDuration: 0.1) { 
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func onPanGesture(_ sender: AnyObject) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {

            if translation.x > 0 && originalLeftMargin + translation.x < self.view.frame.size.width - 200 {
                leftMarginConstraint.constant = originalLeftMargin + translation.x
            }
        } else if sender.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.1, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 200
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        } else {
            print("cancelled")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HAMBURGER VIEW CONTROLLER LOADED")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
