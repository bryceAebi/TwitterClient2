//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/29/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetTable: UITableView!
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.homeTimeline(
            success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tweetTable.reloadData()
                refreshControl.endRefreshing()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
                refreshControl.endRefreshing()
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        TwitterClient.sharedInstance?.homeTimeline(
            success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tweetTable.reloadData()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            }
        )
        
        tweetTable.delegate = self
        tweetTable.dataSource = self
        tweetTable.rowHeight = UITableViewAutomaticDimension
        tweetTable.estimatedRowHeight = 60
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        tweetTable.insertSubview(refreshControl, at: 0)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTable.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TwitterTableViewCell
        cell.setCell(fromTweet: (tweets?[indexPath.row])!)
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let sender = sender as? TwitterTableViewCell {
            let vc = segue.destination as! TweetViewController
            var indexPath = tweetTable.indexPath(for: sender)
            vc.tweet = tweets?[(indexPath?.row)!]
        }
    }

}
