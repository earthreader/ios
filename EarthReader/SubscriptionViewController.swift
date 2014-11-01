//
//  ViewController.swift
//  EarthReader
//
//  Created by Jihyeok Seo on 9/7/14.
//  Copyright (c) 2014 Earth Reader. All rights reserved.
//

import UIKit

class SubscriptionViewController: UITableViewController, NSURLConnectionDataDelegate {
    var feeds: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://127.0.0.1:5000/feeds/")
        var request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        println(data)
        var data = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        var subscriptions = data["feeds"] as NSArray
        for subscription in subscriptions {
            let test = Feed(id: subscription["id"] as String, label: subscription["label"] as String)
            self.feeds.append(test)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as UITableViewCell
        cell.textLabel.text = self.feeds[indexPath.row].label
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

