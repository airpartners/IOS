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
    

    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    

    func webView(_ webView: WKWebView,
      didFinish navigation: WKNavigation!) {
      let scriptSource = """
                            document.getElementById("webonly").style.display = "none";
                            document.getElementsByClassName("makeStyles-toolbar-3")[0].style.display = "none";
                         """
      webView.evaluateJavaScript(scriptSource)
      print("loaded")
    }
    
    func getURLString() -> String {
        let langStr = Locale.preferredLanguages[0]
        print("The lang is: " + langStr)
        var url = "https://airpartners-ade.web.app/SN000-045/Home"
        url += ("/?lang="+langStr)
        return url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let myURL = URL(string: getURLString())
        webView.load(URLRequest(url: myURL!))
    }
}

