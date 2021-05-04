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
        chooseLocationDropDown.show()
    }

    
    let locations = [
    "Orient Heights, EB": "SN000-045",
    "Gibson Park, Revere": "SN000-046",
    "Chelsea Point, Winthrop": "SN000-049",
    "Jeffries Point, EB": "SN000-062",
    "Point Shirley, Winthrop": "SN000-067",
    "Beachmont, Revere": "SN000-114",
    "Contact us": "contact-us",
    "Feedback": "feedback",
    "FAQ": "faq",
    "Privacy Policy": "privacy"]
    
    func setupChooseLocationDropDown() {
        chooseLocationDropDown.anchorView = locationButton
        chooseLocationDropDown.bottomOffset = CGPoint(x: 0, y: locationButton.bounds.height)
        chooseLocationDropDown.direction = .bottom
        chooseLocationDropDown.dataSource = [
            "Orient Heights, EB",
            "Gibson Park, Revere",
            "Chelsea Point, Winthrop",
            "Jeffries Point, EB",
            "Point Shirley, Winthrop",
            "Beachmont, Revere",
            "Contact us",
	    "Feedback",
	    "FAQ",
            "Privacy Policy"
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
                            document.getElementsByClassName("jss3")[0].style.display = "none";
                         """
      webView.evaluateJavaScript(scriptSource)
      print("loaded")
    }
    
    func getURLString(location: String) -> String {
        let langStr = Locale.preferredLanguages[0]
        var url = "https://airpartners-ade.web.app/" + locations[location]!
        url += ("/?lang="+langStr)
        return url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationButton.setTitle("St Andrew Road, EB", for: .normal)
        webView.navigationDelegate = self
        setupChooseLocationDropDown()
        // TODO: Write function that gets location based on coordinates of person
        let myURL = URL(string: getURLString(location: "St Andrew Road, EB"))
        webView.load(URLRequest(url: myURL!))
    }
}

