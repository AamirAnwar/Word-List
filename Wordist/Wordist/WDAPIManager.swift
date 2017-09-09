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
    func didRecieve(response:[String:Any], params:[String:Any]?)
    func didFail(withParams params:[String:Any]?)
}

class WDAPIManager {
    static let sharedInstance = WDAPIManager()
    func getRequestWith(url:URLConvertible, params:[String:Any]?, delegate:WDAPIManagerDelegate) -> DataRequest {
        print(url)
        print(params ?? "")
        return Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            var updatedParams:[String:Any]? = [:]
            if let url = response.request?.url?.absoluteString {
                if var params = params {
                    params["request_url"] = url
                    updatedParams = params
                }
                else {
                    updatedParams = ["request_url":url]
                }
            }
            
            guard response.result.isSuccess else {
                delegate.didFail(withParams:params)
                if let request = response.request {
                    print("Request Failed \(request)")
                }
                return
            }
            // Handle array of dictionaries
            var responseObject = [String:Any]()
            if let responseArray = response.result.value as? Array<Any> {
                responseObject["response"] = responseArray
            }

            delegate.didRecieve(response: responseObject, params:updatedParams)
        }
    }
}
