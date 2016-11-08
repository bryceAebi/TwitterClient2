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
    case userTimeline
}

class TweetFeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tweetTable: UITableView!
    @IBOutlet weak var headerContainer: UIView!
    var tweets: [Tweet]?
    var tweetFilter = TweetFilter.all
    var refreshControl: UIRefreshControl!
    var userID: String?
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        reloadTable(
            success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tweetTable.reloadData()
                refreshControl.endRefreshing()
            },
            failure: { (error: Error) in
                print(error.localizedDescription)
                refreshControl.endRefreshing()
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTable.delegate = self
        tweetTable.dataSource = self
        
        tweetTable.estimatedRowHeight = 100
        tweetTable.rowHeight = UITableViewAutomaticDimension
        
        reloadTable(
            success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tweetTable.reloadData()
            }, failure: { (error: Error ) in
                print(error.localizedDescription)
            }
        )
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        tweetTable.insertSubview(refreshControl, at: 0)
    }
    
    func reloadTable(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        if self.tweetFilter == TweetFilter.mentions {
            TwitterClient.sharedInstance?.mentions(success: success, failure: failure)
        } else if self.tweetFilter == TweetFilter.all {
            TwitterClient.sharedInstance?.homeTimeline(success: success, failure: failure)
        } else {
            var id = (User.currentUser?.id!)!
            if let userID = userID {
                id = userID
            }
            TwitterClient.sharedInstance?.userTimeline(
                userID: id,
                success: success,
                failure: failure
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
        
        if let button = sender as? UIButton {
            let view = button.superview!
            let cell = view.superview as! UITableViewCell
            let indexPath = tweetTable.indexPath(for: cell)
            let vc = segue.destination as! ProfileViewController
            vc.userID = tweets?[(indexPath?.row)!].userID
        }
        
        if let cell = sender as? TwitterTableViewCell {
            var indexPath = tweetTable.indexPath(for: cell)
            let vc = segue.destination as! TweetViewController
            vc.tweet = tweets?[(indexPath?.row)!]
        }
    }

}
