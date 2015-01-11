//
//  SearchResultViewController.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    
    public func HC_SetImageWithURL(url: String) {
        Alamofire.request(.GET, url, parameters: nil, encoding: .URL).response { (request, response, data, error) -> Void in
            if let imageData = data as? NSData {
                var image = UIImage(data: imageData)
                self.image = image
                self.setNeedsDisplay()
            }
        }
    }
}


public class SearchResultViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let doubanButtonIndex = 0
    let duokanButtonIndex = 1
    let amazonButtonIndex = 2
    
    
    @IBOutlet weak var amazonButton: UIButton!
    @IBOutlet weak var doubanButton: UIButton!
    @IBOutlet weak var duokanButton: UIButton!
    
    var selectedResultSet = 0
    
    @IBOutlet weak var tableview: UITableView!
    public var doubanBooks: [DoubanBookModel]?
    public var duokanBooks: [DuokanBookModel]?
    public var keywords: NSString?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.rowHeight = 100
        
        self.doubanButton.setTitle("豆瓣(\(self.doubanBooks!.count))", forState: UIControlState.Normal)
        self.duokanButton.setTitle("多看(\(self.duokanBooks!.count))", forState: UIControlState.Normal)
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedResultSet == doubanButtonIndex {
            return self.doubanBooks!.count
        } else if selectedResultSet == duokanButtonIndex {
            return self.duokanBooks!.count
        }
        
        return 0
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as SearchResultCell

        if selectedResultSet == doubanButtonIndex {
            var book = self.doubanBooks![indexPath.row]
            
            // Configure the cell...
            cell.titleLabel.text = book.title!
            cell.subtitleLabel.text = book.abstract!
            cell.coverImageView.HC_SetImageWithURL(book.cover!)
        } else if selectedResultSet == duokanButtonIndex {
            var book = self.duokanBooks![indexPath.row]
            
            // Configure the cell...
            cell.titleLabel.text = book.title!
            cell.subtitleLabel.text = book.abstract!
            cell.coverImageView.HC_SetImageWithURL(book.cover!)
        }


        return cell
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedResultSet == doubanButtonIndex {
            var book = self.doubanBooks![indexPath.row]
            self.performSegueWithIdentifier("showBookDetail", sender: book)
        } else if selectedResultSet == duokanButtonIndex {
            var book = self.duokanBooks![indexPath.row]
            self.performSegueWithIdentifier("showBookDetail", sender: book)
        }
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // amazon
        if sender == nil && self.keywords != nil {
            var url = "http://www.amazon.cn/gp/aw/s/ref=nb_sb_noss?k=\(escape(self.keywords!))"
            var detailVC = segue.destinationViewController as BookDetailViewController
            detailVC.url = url
            detailVC.title = "Amazon"
            return
        }
        
        if selectedResultSet == doubanButtonIndex {
            var book = sender as DoubanBookModel
            var url = "http://read.douban.com/ebook/\(book.doubanID!)/"
            
            if segue.identifier == "showBookDetail" {
                var detailVC = segue.destinationViewController as BookDetailViewController
                detailVC.url = url
                detailVC.title = book.title!
            }
        } else if selectedResultSet == duokanButtonIndex {
            var book = sender as DuokanBookModel
            var url = "http://www.duokan.com/m/book/\(book.duokanID!)"
            
            if segue.identifier == "showBookDetail" {
                var detailVC = segue.destinationViewController as BookDetailViewController
                detailVC.url = url
                detailVC.title = book.title!
            }
        }
    }

    
    @IBAction func amazonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("showBookDetail", sender: nil)
    }
    
    @IBAction func doubanPressed(sender: AnyObject) {
        self.selectedResultSet = doubanButtonIndex
        self.tableview.reloadData()
        self.tableview.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
    }
    
    @IBAction func duokanPressed(sender: AnyObject) {
        self.selectedResultSet = duokanButtonIndex
        self.tableview.reloadData()
        self.tableview.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":/?&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue)
    }
}
