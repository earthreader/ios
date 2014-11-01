//
//  EntryViewController.swift
//  EarthReader
//
//  Created by Jihyeok Seo on 11/2/14.
//  Copyright (c) 2014 Earth Reader. All rights reserved.
//

import UIKit

class EntryViewContoller: UIViewController, NSURLConnectionDataDelegate {
    
    @IBOutlet var webView: UIWebView!
    var feedID = String()
    var entryID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: NSString(format: "http://127.0.0.1:5000/%@/%@", feedID, entryID))
        var request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        var data = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        let entry = data["entry"] as NSDictionary
        var summary = entry["summary"] as? String
        var content = entry["content"] as? String
        var htmlString = String()
        if (summary != nil && content != nil) {
            htmlString = summary! + content!
        } else if (summary == nil) {
            htmlString = content!
        } else if (content == nil) {
            htmlString = summary!
        }
        self.webView.loadHTMLString(htmlString, baseURL: NSURL(string: entry["id"] as String))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}