//
//  WDWordSearch.swift
//  Wordist
//
//  Created by Aamir  on 09/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation
import Alamofire

protocol WordSearchDelegate {
    func didPerformSearchSuccessfully(forQuery query:String)
    func didFailToSearch(query:String)
}

class WordSearch {
    static let apiEndpoint = "https://api.datamuse.com/words"
    fileprivate var delegate:WordSearchDelegate?
    fileprivate var currentQuery:String?
    var searchResults = [String]()
    fileprivate var currentRequestID:Int?
    
    func performSearch(withQuery query:String, delegate:WordSearchDelegate) {
        if let url = getSearchURLWith(Query: query) {
            currentQuery = query
            self.delegate = delegate
            
            let dataRequestObject =  WDAPIManager.sharedInstance.getRequestWith(url: url, params: nil, delegate:self)
            currentRequestID = dataRequestObject.request?.hashValue
            
        }
    }
    
    fileprivate func getSearchURLWith(Query query:String?) -> String? {
        guard let query = query, query.isEmpty == false else {
            return nil
        }
        let queryString = query.replacingOccurrences(of: " ", with: "")
        return "\(WordSearch.apiEndpoint)?sp=\(queryString)*&md=d&max=50"
    }
    
//    fileprivate func getParams(withQuery query:String) -> [String:String] {
//        guard query.isEmpty == false else {
//            return [:]
//        }
//        let queryString = query.replacingOccurrences(of: " ", with: "")
//        return ["sp":"\(queryString)*","md":"d","query":query]
//    }
    
//    func searchResultsFor(query:String) -> [String] {
//        guard currentQuery == query else {
//            return []
//        }
//        return searchResults
//    }
    
    func clearSearch() {
        currentQuery = nil
        searchResults.removeAll()
    }
}

extension WordSearch:WDAPIManagerDelegate {
    func didRecieve(response: [String : Any], params: [String : Any]?) {
        let currentQueryURLPath = getSearchURLWith(Query: currentQuery)
        
        if let requestURL = params?["request_url"] as? String, requestURL == currentQueryURLPath  {
            searchResults.removeAll()
            if let wordsResponseList = response["response"] as? Array<Any> {
                
                for wordObject in wordsResponseList {
                    if let wordObject = wordObject as? Dictionary<String,Any>, let word = wordObject["word"] as? String {
                        searchResults += [word]
                    }
                }
            }
            delegate?.didPerformSearchSuccessfully(forQuery: currentQuery ?? "")
        }
    }
    
    func didFail(withParams params: [String : Any]?) {
        delegate?.didFailToSearch(query:currentQuery ?? "")
    }
}
