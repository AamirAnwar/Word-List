//
//  WDWordSearch.swift
//  Wordist
//
//  Created by Aamir  on 09/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation


protocol WordSearchDelegate {
    func didPerformSearchSuccessfully(forQuery query:String)
    func didFailToSearch(query:String)
}

class WordSearch {
    static let apiEndpoint = "https://api.datamuse.com/words"
    fileprivate var delegate:WordSearchDelegate?
    fileprivate var currentQuery:String?
    fileprivate var searchResults = [String]()
    
    func performSearch(withQuery query:String, delegate:WordSearchDelegate) {
        if let url = getSearchURLWith(Query: query) {
            currentQuery = query
            self.delegate = delegate
            WDAPIManager.sharedInstance.getRequestWith(url: url, params: getParams(withQuery: query), delegate:self)
        }
    }
    
    fileprivate func getSearchURLWith(Query query:String) -> String? {
        guard query.isEmpty == false else {
            return nil
        }
//        return WordSearch.apiEndpoint
        return "\(WordSearch.apiEndpoint)?sp=\(query)*&md=d"
    }
    
    fileprivate func getParams(withQuery query:String) -> [String:String] {
        guard query.isEmpty == false else {
            return [:]
        }
        return ["sp":"\(query)*","md":"d","query":query]
    }
    
    func searchResultsFor(query:String) -> [String] {
        guard currentQuery == query else {
            return []
        }
        return searchResults
    }
    
    func clearSearch() {
        currentQuery = nil
        searchResults.removeAll()
    }
}

extension WordSearch:WDAPIManagerDelegate {
    func didRecieve(response: [String : Any], params: [String : String]?) {
        
        if let query = params?["query"], query == currentQuery {
            searchResults.removeAll()
            if let wordsResponseList = response["response"] as? Array<Any> {
                
                for wordObject in wordsResponseList {
                    if let wordObject = wordObject as? Dictionary<String,Any>, let word = wordObject["word"] as? String {
                        searchResults += [word]
                    }
                }
            }
            delegate?.didPerformSearchSuccessfully(forQuery: query)
        }
    }
    
    func didFail() {
        
    }
}
