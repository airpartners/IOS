//
//  ViewController.swift
//  EBAirQuality
//
//  Created by Nina Tchirkova on 6/8/20.
//  Copyright © 2020 Air Partners. All rights reserved.
//

import UIKit
import WebKit
import DropDown

class ViewController: UIViewController, WKNavigationDelegate {
    

    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var locationButton: UIButton!
    
    let chooseLocationDropDown = DropDown()
    
    @IBAction func chooseLocation(_ sender: Any) {
        let result = chooseLocationDropDown.show()
        print("Can the drop down be displayed? " + String(result.0))
    }
    //    @IBAction func chooseLocation(_ sender: AnyObject) {
//        let result = chooseLocationDropDown.show()
//        print("Can the drop down be displayed? " + String(result.0))
//        // how do I make drop down show???
//    }
    
    let locations = ["St Andrew Road, EB": "SN000-045",
    "Everett Street, EB": "SN000-046",
    "Elmer Ave, Winthrop": "SN000-049",
    "Sumner, EB": "SN000-062",
    "Bay View Ave, Winthrop": "SN000-067",
    "Anna Voy, EB": "SN000-072",
    "Contact us": "contact-us"]
    
    func setupChooseLocationDropDown() {
        chooseLocationDropDown.anchorView = locationButton
        chooseLocationDropDown.bottomOffset = CGPoint(x: 0, y: locationButton.bounds.height)
        chooseLocationDropDown.direction = .bottom
        chooseLocationDropDown.dataSource = [
            "St Andrew Road, EB",
            "Everett Street, EB",
            "Elmer Ave, Winthrop",
            "Sumner, EB",
            "Bay View Ave, Winthrop",
            "Anna Voy, EB",
            "Contact us"
        ]
        
        // Action triggered on selection
        chooseLocationDropDown.selectionAction = { [weak self] (index, item) in
            self?.locationButton.setTitle(item, for: .normal)
            let myURL = URL(string: (self?.getURLString(location: item))!)
            self?.webView.load(URLRequest(url: myURL!))
        }
    }
    
    func webView(_ webView: WKWebView,
      didFinish navigation: WKNavigation!) {
      let scriptSource = """
                            document.getElementById("webonly").style.display = "none";
                            document.getElementsByClassName("makeStyles-toolbar-3")[0].style.display = "none";
                         """
      webView.evaluateJavaScript(scriptSource)
      print("loaded")
    }
    
    func getURLString(location: String) -> String {
        let langStr = Locale.preferredLanguages[0]
        print("The lang is: " + langStr)
        var url = "https://airpartners-ade.web.app/" + locations[location]!
        url += ("/?lang="+langStr)
        return url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setupChooseLocationDropDown()
        // TODO: Write function that gets location based on coordinates of person
        let myURL = URL(string: getURLString(location: "St Andrew Road, EB"))
        webView.load(URLRequest(url: myURL!))
    }
}

