//
//  LoginViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/28/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(
            success: {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                let hamburgerViewController = storyboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
                let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                hamburgerViewController.menuViewController = menuViewController
                menuViewController.hamburgerViewController = hamburgerViewController
                self.present(hamburgerViewController, animated: true)
            }, failure: { (error: Error) in
                print("Error: \(error.localizedDescription)")
            }
        )
    }

}
