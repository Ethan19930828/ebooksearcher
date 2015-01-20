//
//  UIViewController+ProgressHud.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/19.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

var mm_loadingViewHandler: Int = 0
var mm_loadingViewLabelHandler:Int = 0

extension UIViewController {
    private var mm_loadingView: UIView? {
        get {
            return objc_getAssociatedObject(self, &mm_loadingViewHandler) as? UIView
        }
        
        set {
            objc_setAssociatedObject(self, &mm_loadingViewHandler, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    private var mm_loadingLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &mm_loadingViewLabelHandler) as? UILabel
        }
        
        set {
            objc_setAssociatedObject(self, &mm_loadingViewLabelHandler, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    func mm_showLoading(msg: String) {
        if mm_loadingView == nil {
            createLoadingView()
        }
        
        mm_loadingLabel?.text = msg
        self.view.addSubview(mm_loadingView!)
    }
    
    func mm_hideLoading() {
        if mm_loadingView != nil {
            mm_loadingView!.removeFromSuperview()
        }
    }
    
    func mm_showError(msg: String) {
        var alertView = UIAlertView(title: "ERROR", message: msg, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    private func createLoadingView() {
        var height = self.view.bounds.width / 3
        var width = height
        var loadingView = UIView(frame: CGRectMake((CGRectGetWidth(self.view.bounds) - width) / 2,
            (self.view.bounds.size.height - height) / 2, width, height))
        
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8);
        loadingView.alpha = 1;
        loadingView.layer.cornerRadius = 5
        loadingView.layer.shadowOffset = CGSizeMake(1, 1)
        
        var label = UILabel(frame: CGRectMake(0, height / 2 + 10, loadingView.bounds.size.width, 20))
        label.textAlignment = .Center
        label.text = "loading..."
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.whiteColor()
        mm_loadingLabel = label
        
        var activiyView = UIActivityIndicatorView(frame: CGRectMake((loadingView.bounds.size.width - 50) / 2, height / 2 - 50, 50, 50))
        
        loadingView.addSubview(activiyView)
        loadingView.addSubview(label)
        activiyView.startAnimating()
        mm_loadingView = loadingView
    }
}