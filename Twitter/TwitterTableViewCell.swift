//
//  TwitterTableViewCell.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/29/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit
import AFNetworking

class TwitterTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var postedTime: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    var tweet: Tweet!
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favorite(tweet: tweet!, success: { (datatask: URLSessionDataTask, response: Any?) in
            self.favoriteButton.setImage(UIImage(named: "star-green"), for: .normal)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print(error.localizedDescription)
        })
    }
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(tweet: tweet!, success: { (task: URLSessionDataTask, response: Any?) in
            self.retweetButton.setImage(UIImage(named: "retweet-green"), for: .normal)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print(error.localizedDescription)
        })
    }
    
    func setCell(fromTweet tweet: Tweet) {
        self.tweet = tweet
        userProfilePic.setImageWith(tweet.profilePic as! URL)
        tweetLabel.text = tweet.text
        userNameLabel.text = tweet.username
        if let screenname = tweet.screenname {
            userHandle.text = "@\(screenname)"
        }
        postedTime.text = tweet.timestamp?.description
        if let retweeted = tweet.retweeted {
            if retweeted {
                retweetButton.setImage(UIImage(named: "retweet-green"), for: .normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
            }
        }
        if let favorited = tweet.favorited {
            if favorited {
                favoriteButton.setImage(UIImage(named: "star-green"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "star"), for: .normal)
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userProfilePic.layer.cornerRadius = 3
        userProfilePic.clipsToBounds = true
    }

}
