//
//  DoubanBookDetailViewController.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit
 class BookDetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    var url: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.url != nil {
            var request = NSURLRequest(URL: NSURL(string: self.url!)!)
            self.webview.loadRequest(request)
            self.webview.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: WebviewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        self.mm_showLoading("正在加载...")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.mm_hideLoading()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.mm_hideLoading()
        self.mm_showError(error.description)
    }

}
