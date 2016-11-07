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

class TweetDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var tweetTable: UITableView!
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
    
    init(tableView: UITableView, tweetFilter: TweetFilter) {
        super.init()
        
        self.tweetFilter = tweetFilter
        self.tweetTable = tableView
        
        tweetTable.delegate = self
        tweetTable.dataSource = self
        
        reloadTable()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        tweetTable.insertSubview(refreshControl, at: 0)
    }
    
    func reloadTable() {
        if self.tweetFilter == TweetFilter.mentions {
            TwitterClient.sharedInstance?.mentions(
                success: { (tweets: [Tweet]) in
                    self.tweets = tweets
                    self.tweetTable.reloadData()
                }, failure: { (error: Error) in
                    print(error.localizedDescription)
                }
            )
        } else {
            TwitterClient.sharedInstance?.homeTimeline(
                success: { (tweets: [Tweet]) in
                    self.tweets = tweets
                    self.tweetTable.reloadData()
                }, failure: { (error: Error) in
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

}
