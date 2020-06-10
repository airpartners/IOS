//
//  ViewController.swift
//  EBAirQuality
//
//  Created by Nina Tchirkova on 6/8/20.
//  Copyright © 2020 Air Partners. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myURL = URL(string: "https://minhkhang1795.github.io/aq-web-client/")!
        webView.load(URLRequest(url: myURL))
    }

    
    
}

