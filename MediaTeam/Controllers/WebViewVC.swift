//
//  WebViewVC.swift
//  MediaTeam
//
//  Created by Abdur Rauf on 22/04/2021.
//  Copyright © 2021 Abdur Rauf. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var activityIndicatr: UIActivityIndicatorView!
    @IBOutlet weak var webViews: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.youtube.com/playlist?list=PLHhCyW7UUBnYhQcyGAR6s9gh9noVopUIJ") else { return }
           webViews.translatesAutoresizingMaskIntoConstraints = false
           webViews.isUserInteractionEnabled = true
           self.view.addSubview(self.webViews)
           let request = URLRequest(url: url)
           webViews.load(request)
        self.webViews.addSubview(self.activityIndicatr)
        self.activityIndicatr.startAnimating()
        self.webViews.navigationDelegate = self
        self.activityIndicatr.hidesWhenStopped = true
        

        
    }
    @IBAction func goBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatr.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatr.stopAnimating()
    }

}
