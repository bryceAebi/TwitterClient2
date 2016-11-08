//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/29/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit


class TweetsViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!

    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetFeedViewController = storyboard.instantiateViewController(withIdentifier: "TweetFeedViewController") as! TweetFeedViewController
        self.addChildViewController(tweetFeedViewController)
        tweetFeedViewController.view.frame = contentView.bounds
        tweetFeedViewController.willMove(toParentViewController: self)
        tweetFeedViewController.headerContainer.isHidden = true
        contentView.addSubview(tweetFeedViewController.view)
        tweetFeedViewController.didMove(toParentViewController: self)
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}
