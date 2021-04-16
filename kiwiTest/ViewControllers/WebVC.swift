//
//  WebVC.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 16.4.21..
//

import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {

    //MARK: - API
    var urlString: String?
    
    //MARK: - Properties
    private var webView: WKWebView!
    
    //MARK: - Lifecycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        navigationController?.navigationBar.tintColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = self.urlString, let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
