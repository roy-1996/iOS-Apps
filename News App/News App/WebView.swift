//
//  WebView.swift
//  News App
//
//  Created by RONIT NATH on 16/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController {
    

    var url : String?   /* Optional because there is no guarantee an url will exist */
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest( url : URL(string: url! )!))
        
        
        // Do any additional setup after loading the view.
    }
    

  

}
