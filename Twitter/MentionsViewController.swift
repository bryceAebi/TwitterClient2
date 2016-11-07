//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/6/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
    
    
    var tweetDataSource: TweetDataSource!
    
    @IBOutlet weak var tweetTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#4099ffff")
        
        let titleDict: [String:Any] = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        tweetDataSource = TweetDataSource(tableView: tweetTable, tweetFilter: TweetFilter.mentions)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let sender = sender as? TwitterTableViewCell {
            let vc = segue.destination as! TweetViewController
            var indexPath = tweetTable.indexPath(for: sender)
            vc.tweet = tweetDataSource.tweets?[(indexPath?.row)!]
        }
    }
}
