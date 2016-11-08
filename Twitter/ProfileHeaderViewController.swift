//
//  ProfileHeaderViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/7/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ProfileHeaderViewController: UIViewController {
    var user: User?
    var userID: String?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    func loadView(user: User) {
        if let screenname = user.name {
            screennameLabel.text = "@\(screenname)"
        }
        if let userTweetCount = user.tweetCount {
            tweetsCount.text = String(userTweetCount)
        } else {
            tweetsCount.text = ""
        }
        if let userFollowingCount = user.followingCount {
            followingCount.text = String(userFollowingCount)
        } else {
            followingCount.text = ""
        }
        if let userFollowersCount = user.followersCount {
            followersCount.text = String(userFollowersCount)
        } else {
            followersCount.text = ""
        }
        usernameLabel.text = user.name
        if let url = user.profileUrl {
            profileImageView.setImageWith(url)
            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
        }
        if let backgroundURL = user.backgroundImageUrl {
            backgroundImageView.setImageWith(backgroundURL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = userID {
            TwitterClient.sharedInstance?.user(
                userID: userID,
                success: { (user: User) in
                    self.loadView(user: user)
                }, failure: { (error: Error) in
                    print(error.localizedDescription)
                }
            )
        } else if let user = User.currentUser {
            loadView(user: user)
        }
    }

}
