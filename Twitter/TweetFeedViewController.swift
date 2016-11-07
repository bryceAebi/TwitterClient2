//
//  TweetDataSource.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/6/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

enum TweetFilter {
    case all
    case mentions
}

class TweetFeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tweetTable: UITableView!
    
    var tweets: [Tweet]?
    var tweetFilter: TweetFilter!
    var refreshControl: UIRefreshControl!
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        if self.tweetFilter == TweetFilter.mentions {
            TwitterClient.sharedInstance?.mentions(
                success: { (tweets: [Tweet]) in
                    self.tweets = tweets
                    self.tweetTable.reloadData()
                    refreshControl.endRefreshing()
                }, failure: { (error: Error) in
                    print(error.localizedDescription)
                    refreshControl.endRefreshing()
                }
            )
        } else {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetFilter = TweetFilter.all
        
        tweetTable.delegate = self
        tweetTable.dataSource = self
        
        reloadTable()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        tweetTable.insertSubview(refreshControl, at: 0)
        print(tweets)
    }
    
    func reloadTable() {
        print("LOADING THE TWEETS")
        if self.tweetFilter == TweetFilter.mentions {
            TwitterClient.sharedInstance?.mentions(
                success: { (tweets: [Tweet]) in
                    print("SUCCESSFUL")
                    self.tweets = tweets
                    self.tweetTable.reloadData()
                }, failure: { (error: Error) in
                    print("FAILURE")
                    print(error.localizedDescription)
                }
            )
        } else {
            TwitterClient.sharedInstance?.homeTimeline(
                success: { (tweets: [Tweet]) in
                    print("SUCCESSFUL")
                    print(tweets)
                    self.tweets = tweets
                    self.tweetTable.reloadData()
                }, failure: { (error: Error) in
                    print("FAILURE")
                    print(error.localizedDescription)
                }
            )
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
