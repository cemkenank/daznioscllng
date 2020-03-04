//
//  DetailViewController.swift
//  DAZN Challange
//
//  Created by MrDark on 4.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var detailLink = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: detailLink)
        let request = URLRequest(url: url!)
        webView.load(request)
        

        // Do any additional setup after loading the view.
    }

}
