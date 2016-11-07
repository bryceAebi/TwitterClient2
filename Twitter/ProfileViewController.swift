//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var tweetDataSource: TweetDataSource!
   
    @IBOutlet weak var tweetTable: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let screenname = User.currentUser?.name {
            screennameLabel.text = "@\(screenname)"
        }
        if let userTweetCount = User.currentUser?.tweetCount {
            tweetsCount.text = String(userTweetCount)
        } else {
            tweetsCount.text = ""
        }
        if let userFollowingCount = User.currentUser?.followingCount {
            followingCount.text = String(userFollowingCount)
        } else {
            followingCount.text = ""
        }
        if let userFollowersCount = User.currentUser?.followersCount {
            followersCount.text = String(userFollowersCount)
        } else {
            followersCount.text = ""
        }
        usernameLabel.text = User.currentUser?.name
        if let url = User.currentUser?.profileUrl {
            profileImageView.setImageWith(url)
            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
        }
        if let backgroundURL = User.currentUser?.backgroundImageUrl {
            backgroundImageView.setImageWith(backgroundURL)
        }
        
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        tweetDataSource = TweetDataSource(tableView: tweetTable, tweetFilter: TweetFilter.all)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
