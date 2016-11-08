//
//  Tweet.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/29/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var username: String?
    var profilePic: URL?
    var screenname: String?
    var tweetID: String?
    var favorited: Bool?
    var retweeted: Bool?
    var userID: String?
    
    init(dictionary: NSDictionary) {
        tweetID = dictionary["id_str"] as? String
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        favorited = (dictionary["favorited"] as? Bool) ?? false
        retweeted = (dictionary["retweeted"] as? Bool) ?? false
        
        let userDict = dictionary["user"] as? NSDictionary
        if let userDict = userDict {
            username = userDict["name"] as? String
            screenname = userDict["screen_name"] as? String
            profilePic = URL(string: userDict["profile_image_url_https"] as! String)
            userID = userDict["id_str"] as? String
            print(userID)
        }
        
        let timestampString = dictionary["created_at"] as? String

        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
