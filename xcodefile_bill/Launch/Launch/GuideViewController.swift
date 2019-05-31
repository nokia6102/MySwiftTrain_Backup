//
//  GuideViewController.swift
//  Launch
//
//  Created by user on 2019/6/1.
//  Copyright © 2019 com.USSwiftCoda. All rights reserved.
//

import UIKit
import WebKit

class GuideViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.webView.load(NSURLRequest(url: NSURL(string: "http://studio-pj.com/swift/index.html")! as URL) as URLRequest)
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
