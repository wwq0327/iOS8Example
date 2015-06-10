//
//  Network.swift
//  BuildYourHTTPRequestLibrary
//
//  Created by wyatt on 15/5/30.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import Foundation

class Network {
    static func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let session = NSURLSession.sharedSession()
        
        // 组合url及参数，生成新的url
        var newURL = url
        if method == "GET" {
            newURL += "?" + Network().buildParams(params)
        }
        

        let request = NSMutableURLRequest(URL: NSURL(string: newURL)!)
        request.HTTPMethod = method
        
        // POST方法， 文件上传模块
        if method == "POST" {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = Network().buildParams(params).dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        // 任务闭包
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            callback(data: data, response: response, error: error)
        })
        
        task.resume()
    }
    
    
    // 参数处理
    func buildParams(parameters: [String:AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in sorted(Array(parameters.keys), <) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return join("&", components.map{"\($0)=\($1)"} as [String])
    }
    
    
    // 查询
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.extend([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    // 转换
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscape: CFStringRef = ":&=;!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscape, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}