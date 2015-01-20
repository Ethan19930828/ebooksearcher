//
//  BaseModel.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit

public class BaseModel: NSObject {
    var json: JSON?
    
    public init(json: JSON?) {
        super.init()
        self.json = json;
    }
    
    public func propertyNamed(proertyName: String) -> JSON? {
        return self.json?[proertyName]
    }
}
