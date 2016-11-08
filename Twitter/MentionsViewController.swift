//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/6/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
        
    var tweetFeedController: TweetFeedViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navbar style
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetFeedViewController = storyboard.instantiateViewController(withIdentifier: "TweetFeedViewController") as! TweetFeedViewController
        tweetFeedViewController.tweetFilter = TweetFilter.mentions
        self.addChildViewController(tweetFeedViewController)
        tweetFeedViewController.view.frame = contentView.bounds
        tweetFeedViewController.willMove(toParentViewController: self)
        contentView.addSubview(tweetFeedViewController.view)
        tweetFeedViewController.didMove(toParentViewController: self)
    }

}
