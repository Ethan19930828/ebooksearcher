//
//  BaseViewController.swift
//  HerculesCommonLibrary
//
//  Created by TCASSEMBLER on 14/12/9.
//  Copyright (c) 2014年 topcoder inc. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    var loadingView: UIView?

    func hideLoading() {
        self.loadingView?.hidden = true;
    }
    
    func showLoading() {
        //var acticityVie
        
        if self.loadingView == nil {
            var loadingView = UIView(frame: CGRectMake(10, (self.view.bounds.size.height - 100) / 2, self.view.bounds.size.width - 20, 100))
            loadingView.backgroundColor = UIColor.blackColor();
            loadingView.alpha = 0.8;
            
            var label = UILabel(frame: CGRectMake(0, 60, loadingView.bounds.size.width, 20))
            label.textAlignment = .Center
            label.text = "loading..."
            label.font = UIFont.systemFontOfSize(14)
            label.textColor = UIColor.lightGrayColor()
            var activiyView = UIActivityIndicatorView(frame: CGRectMake((loadingView.bounds.size.width - 50) / 2, 10, 50, 50))
            
            loadingView.addSubview(activiyView)
            loadingView.addSubview(label)
            self.view.addSubview(loadingView)
            activiyView.startAnimating()
            self.loadingView = loadingView
        }
        self.loadingView?.hidden = false
        
    }
    
    public func error(msg: String) {
        
        var alertView = UIAlertView(title: "ERROR", message: msg, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }

}
