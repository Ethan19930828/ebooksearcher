//
//  ViewController.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var doubanBooks: [DoubanBookModel]?
    var duokanBooks: [DuokanBookModel]?
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(sender: AnyObject) {
        self.mm_showLoading("正在搜索...")
        SearchService.searchDouban(keywords: searchTextField.text, sucessBlock: { (books) -> () in
                self.doubanBooks = books
                self.searchDuokan()
            }) { (error) -> () in
                self.searchDuokan()
        }
    }
    
    func searchDuokan() {
        SearchService.searchDuokan(keywords: searchTextField.text, sucessBlock: { (duokanbooks) -> () in
            self.duokanBooks = duokanbooks
            self.searchAmazon()
        }) { (error) -> () in
            self.searchAmazon()
        }
    }
    
    func searchAmazon() {
        self.mm_hideLoading()
        self.performSegueWithIdentifier("showSearchResult", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSearchResult" {
            var searchResultVC = segue.destinationViewController as SearchResultViewController
            searchResultVC.doubanBooks = self.doubanBooks
            searchResultVC.duokanBooks = self.duokanBooks
            searchResultVC.keywords = searchTextField.text
            searchResultVC.title = "搜索:( \(searchTextField.text) )"
        }
    }

}

