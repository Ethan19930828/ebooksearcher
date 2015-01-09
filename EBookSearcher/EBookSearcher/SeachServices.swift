//
//  SeachServices.swift
//  EBookSearcher
//
//  Created by Miaowei Wu on 15/1/9.
//  Copyright (c) 2015年 miaomaocat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public typealias SearchDoubanSucessBlock = ([DoubanBookModel]) -> ()
public typealias APIFailBlock = (NSError?) -> ()

public class SeachServices: NSObject {
   
    public class func searchDouban(#keywords: NSString, sucessBlock: SearchDoubanSucessBlock?, failBlock: APIFailBlock?) {
        var url = "http://read.douban.com/j/search?start=0&limit=100"
        
        Alamofire.request(.GET, url, parameters: ["query": keywords], encoding: .URL).response { (request, response, data, error) -> Void in
            println(request)
            println(response)
            
            if error != nil {
                failBlock? (error)
                return
            }
            
            if let jsonData = data as? NSData {
                var books = DoubanBookModel.modelsFromResponse(jsonData)
                sucessBlock? (books)
            }
            
        }
    }
}
