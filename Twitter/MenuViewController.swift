//
//  MenuViewController.swift
//  Twitter
//
//  Created by Bryce Aebi on 11/5/16.
//  Copyright © 2016 Bryce Aebi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var profileViewController: UIViewController!
    private var timelineViewController: UIViewController!
    private var mentionsViewController: UIViewController!
    
    var hamburgerViewController: HamburgerViewController! {
        didSet {
            hamburgerViewController.contentViewController = timelineViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        timelineViewController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        let titles = ["Home", "Profile", "Mentions", "Sign Out"]
        cell.title.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            hamburgerViewController.contentViewController = timelineViewController
        } else if indexPath.row == 1 {
            hamburgerViewController.contentViewController = profileViewController
        } else if indexPath.row == 2 {
            hamburgerViewController.contentViewController = mentionsViewController
        }
    }

}
