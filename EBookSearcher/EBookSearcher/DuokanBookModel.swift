//
//  DuokanBookModel.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/11.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit

public class DuokanBookModel: BaseModel {
    
    public class func modelsFromResponse(data: NSData) -> [DuokanBookModel] {
        var models = [DuokanBookModel]()
        
        var json = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        for (index: String, modelJson) in json["items"] {
            var model = DuokanBookModel(json: modelJson)
            models.append(model)
        }
        return models
    }
   
    /// duokanID
    public var duokanID: String? {
        get {
            var sid = self.propertyNamed("sid")?.number
            if sid != nil {
                return "\(sid!)"
            } else {
                return ""
            }
        }
    }
    
    /// author
    public var author: String? {
        get {
            return self.propertyNamed("authors")?.string
        }
    }
    
    /// abstract
    public var abstract: String? {
        get {
            return self.propertyNamed("summary")?.string
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
