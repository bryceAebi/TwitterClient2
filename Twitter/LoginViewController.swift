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
                self.performSegue(withIdentifier: "loginSegue", sender: nil)            
            }, failure: { (error: Error) in
                print("Error: \(error.localizedDescription)")
            }
        )
    }

}
