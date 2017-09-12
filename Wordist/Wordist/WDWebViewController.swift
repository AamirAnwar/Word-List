//
//  WDWebViewController.swift
//  Wordist
//
//  Created by Aamir  on 12/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit
import WebKit

class WDWebViewController: UIViewController,WDNavigationHeaderDelegate {
    let webView = WKWebView()
    let headerView = WDNavigationHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // Navigation header view
        headerView.setBackButton(title: "")
        if let backTitle = self.navigationController?.navigationBar.items?.last?.title {
            headerView.setBackButton(title: backTitle)
        }
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        // Constraints
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant:kStatusBarHeight),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: kNavigationBarHeight)
            ])
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.maximumZoomScale = 1
        webView.scrollView.minimumZoomScale = 1
        view.addSubview(webView)
        
        var bottomPadding = kDefaultPadding
        if let tabBarHeight = self.tabBarController?.tabBar.frame.height {
            bottomPadding += tabBarHeight
        }
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:kSidePadding),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-kSidePadding),
            webView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant:kDefaultPadding),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-bottomPadding)
            ])
        
        
        if let urlString = Bundle.main.path(forResource: "licences", ofType: "html"), let _ = URL(string:urlString) {
            do {
                let htmlString = try NSString(contentsOfFile: urlString, encoding: String.Encoding.utf8.rawValue)
                
                webView.loadHTMLString(htmlString as String, baseURL: nil)
                
            }
            catch {
                print("Invalid HTML")
            }
        }
        
    }

    func didTapBackButton() {
         self.navigationController?.popViewController(animated: true)
    }
    
 

}
