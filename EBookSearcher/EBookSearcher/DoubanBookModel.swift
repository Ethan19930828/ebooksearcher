//
//  DoubanBookModel.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit
import SwiftyJSON

public class DoubanBookModel: BaseModel {
    
    public class func modelsFromResponse(data: NSData) -> [DoubanBookModel] {
        var models = [DoubanBookModel]()
        
        var json = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        for (index: String, modelJson) in json {
            var model = DoubanBookModel(json: modelJson)
            models.append(model)
        }
        return models
    }
    
    /// doubanID
    public var doubanID: String? {
        get {
            return self.propertyNamed("id")?.string
        }
    }
    
    /// subtitle
    public var subtitle: String? {
        get {
            return self.propertyNamed("subtitle")?.string
        }
    }
    
    /// author
    public var author: String? {
        get {
            return self.propertyNamed("author")?.string
        }
    }
    
    /// abstract
    public var abstract: String? {
        get {
            return self.propertyNamed("abstract")?.string
        }
    }
    
    /// cover
    public var cover: String? {
        get {
            return self.propertyNamed("cover")?.string
        }
    }
    
    /// title
    public var title: String? {
        get {
            return self.propertyNamed("title")?.string
        }
    }
}
