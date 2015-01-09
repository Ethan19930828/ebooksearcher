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

public class SearchResultViewController: UITableViewController {

    public var books: [DoubanBookModel]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books!.count
    }

    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as SearchResultCell

        var book = self.books![indexPath.row]
        
        // Configure the cell...
        cell.titleLabel.text = book.title!
        cell.subtitleLabel.text = book.abstract!
        cell.coverImageView.HC_SetImageWithURL(book.cover!)

        return cell
    }
}
