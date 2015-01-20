//
//  UIImageView+URL.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/20.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC
import Alamofire

var requestHandler: Int = 0

extension UIImageView {
    
    private var mm_request: Request? {
        get {
            return objc_getAssociatedObject(self, &requestHandler) as? Request
        }
        set {
            objc_setAssociatedObject(self, &requestHandler, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    public func mm_setImageWithURL(url: String) {
        
        // cancel old request
        if mm_request != nil {
            mm_request?.cancel()
        }
        
        var request = Alamofire.request(.GET, url, parameters: nil, encoding: .URL).response { (request, response, data, error) -> Void in
            if let imageData = data as? NSData {
                var image = UIImage(data: imageData)
                self.image = image
                self.setNeedsDisplay()
            }
        }
        
        mm_request = request
    }
}