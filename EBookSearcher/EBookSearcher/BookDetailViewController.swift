//
//  DoubanBookDetailViewController.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit

public class BookDetailViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    public var url: NSString?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if self.url != nil {
            var request = NSURLRequest(URL: NSURL(string: self.url!)!)
            self.webview.loadRequest(request)
        }
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
