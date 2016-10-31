//
//  TweetViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/30/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var screenname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var timePosted: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.setImageWith(tweet?.profilePic as! URL)
        profilePic.layer.cornerRadius = 3
        profilePic.clipsToBounds = true
        
        tweetLabel.text = tweet?.text
        screenname.text = "@\((tweet?.screenname)!)"
        username.text = tweet?.username
        
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
        favoritesCountLabel.text = "\((tweet?.favoritesCount)!)"
        
        timePosted.text = tweet?.timestamp?.description
        
        if let retweeted = tweet?.retweeted {
            if retweeted {
                retweetButton.setImage(UIImage(named: "retweet-green"), for: .normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
            }
        }
        if let favorited = tweet?.favorited {
            if favorited {
                favoriteButton.setImage(UIImage(named: "star-green"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "star"), for: .normal)
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let vc = nav.topViewController as! NewTweetViewController
        vc.replyTo = "@\(tweet!.screenname!) "
    }

}
