//
//  ViewController.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var books: [DoubanBookModel]?
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(sender: AnyObject) {
        SeachServices.searchDouban(keywords: searchTextField.text, sucessBlock: { (books) -> () in
            self.books = books
            self.performSegueWithIdentifier("showSearchResult", sender: nil)
            }) { (error) -> () in
        }
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
            searchResultVC.books = self.books
        }
    }

}

