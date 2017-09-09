//
//  WDAPIManager.swift
//  Wordist
//
//  Created by Aamir  on 09/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation
import Alamofire

protocol WDAPIManagerDelegate {
    func didRecieve(response:[String:Any], params:[String:String]?)
    func didFail()
}

class WDAPIManager {
    static let sharedInstance = WDAPIManager()
    func getRequestWith(url:URLConvertible, params:[String:String]?, delegate:WDAPIManagerDelegate) {
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else {
                delegate.didFail()
                return
            }
            // Handle array of dictionaries
            var responseObject = [String:Any]()
            if let responseArray = response.result.value as? Array<Any> {
                responseObject["response"] = responseArray
            }
            
            delegate.didRecieve(response: responseObject, params:params)
        }
    }
}
