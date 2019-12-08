//
//  resourcesViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 20/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import WebKit

class resourcesViewController: UIViewController, WKUIDelegate{
    
     var myURL = URL(string:"https://www.arfidawarenessuk.org")

    @IBOutlet weak var webWindow: WKWebView!
  
    @IBAction func AAUK(_ sender: UIButton) {
        myURL = URL(string:"https://www.arfidawarenessuk.org")
        let myRequest = URLRequest(url: myURL!)
        webWindow.load(myRequest)

       // webWindow.reload()
    }
    
    @IBAction func reddit(_ sender: UIButton) {
  
        myURL = URL(string:"https://www.reddit.com/r/ARFID/")
        let myRequest = URLRequest(url: myURL!)
        webWindow.load(myRequest)

        //webWindow.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let myRequest = URLRequest(url: myURL!)
        webWindow.load(myRequest)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           print(error)
       }



}
