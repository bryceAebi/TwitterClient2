//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/30/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    var replyTo: String?
    
    @IBAction func onTweet(_ sender: AnyObject) {
        textField.endEditing(true)
        TwitterClient.sharedInstance?.tweet(tweetText: textField.text, success: { (task: URLSessionDataTask, response: Any?) in
                self.dismiss(animated: true, completion: nil)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print(error.localizedDescription)
            }
        )
    }

    @IBAction func onCancel(_ sender: AnyObject) {
        textField.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        
        if let user = User.currentUser {
            profilePicImageView.setImageWith(user.profileUrl!)
            usernameLabel.text = user.name
            screennameLabel.text = "@\(user.screenname!)"
        }
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
        
        textField.text = replyTo ?? ""
    }
}
