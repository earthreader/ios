//
//  FeedViewController.swift
//  EarthReader
//
//  Created by Jihyeok Seo on 11/2/14.
//  Copyright (c) 2014 Earth Reader. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController, NSURLConnectionDataDelegate {
    
    var entries: [Entry] = []
    var feedID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: NSString(format: "http://127.0.0.1:5000/%@/", feedID))
        var request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        var data = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        var entries = data["entries"] as NSArray
        for entry in entries {
            let test = Entry(id: entry["id"] as String, title: entry["title"] as String)
            self.entries.append(test)
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForSelectedRow()
        var destinationViewController = segue.destinationViewController as EntryViewContoller
        destinationViewController.feedID = self.feedID
        destinationViewController.entryID = self.entries[indexPath!.row].id
        destinationViewController.title = self.entries[indexPath!.row].title
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EntryCell") as UITableViewCell
        cell.textLabel.text = self.entries[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}