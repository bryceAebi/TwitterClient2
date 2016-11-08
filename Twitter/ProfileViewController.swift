//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    var tweetFeedViewController: TweetFeedViewController!
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetFeedViewController = storyboard.instantiateViewController(withIdentifier: "TweetFeedViewController") as! TweetFeedViewController
        tweetFeedViewController.userID = userID
        tweetFeedViewController.tweetFilter = TweetFilter.userTimeline
        //tweetFeedViewController.reloadTable()
        self.addChildViewController(tweetFeedViewController)
        tweetFeedViewController.view.frame = contentView.bounds
        tweetFeedViewController.willMove(toParentViewController: self)
        contentView.addSubview(tweetFeedViewController.view)
        tweetFeedViewController.didMove(toParentViewController: self)
        
        let profileHeaderController = storyboard.instantiateViewController(withIdentifier: "ProfileHeader") as! ProfileHeaderViewController
        
        profileHeaderController.userID = userID
        tweetFeedViewController.addChildViewController(profileHeaderController)
        profileHeaderController.view.frame = tweetFeedViewController.headerContainer.bounds
        profileHeaderController.willMove(toParentViewController: self)
        tweetFeedViewController.headerContainer.frame.size.height = 250
        tweetFeedViewController.headerContainer.addSubview(profileHeaderController.view)
        profileHeaderController.didMove(toParentViewController: self)
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

}
