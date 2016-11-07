//
//  TwitterClient.swift
//  Twitter
//
//  Created by Bryce Aebi on 10/29/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "jPQkPdfMvCBMzmdbgggCCgBQF", consumerSecret: "EugsQmToDeUbmMrWjP7z9KTRArO697GIFuFR2cRAeKftZLQliQ")

    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }) { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func tweet(tweetText: String, success: @escaping (URLSessionDataTask, Any?) -> (), failure: @escaping (URLSessionDataTask?, Error) -> () ) {
        post("1.1/statuses/update.json", parameters: ["status": tweetText], progress: nil, success: success, failure: failure)
    }
    
    func retweet(tweet: Tweet, success: @escaping (URLSessionDataTask, Any?) -> (), failure: @escaping (URLSessionDataTask?, Error) -> ()) {
        post("1.1/statuses/retweet/\(tweet.tweetID!).json", parameters: nil, progress: nil, success: success, failure: failure)
    }
    
    func favorite(tweet: Tweet, success: @escaping (URLSessionDataTask, Any?) -> (), failure: @escaping (URLSessionDataTask?, Error) -> ()) {
        post("1.1/favorites/create.json", parameters: ["id": tweet.tweetID!], progress: nil, success: success, failure: failure)
    }
    
    func currentAccount(success: @escaping (User) ->(), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                success(user)
            },
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
    
    func mentions(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) in
            self.currentAccount(
                success: { (user: User) in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
                }
            )
            }, failure: { (error: Error?) in
                print("error: \(error!.localizedDescription)")
                self.loginFailure?(error!)
            }
        )
    }
}
