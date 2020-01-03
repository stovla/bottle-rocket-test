//
//  InternetsViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 03/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit
import WebKit

class InternetsViewController: UIViewController, WKNavigationDelegate {

    private var appHomePage = "https://www.bottlerocketstudios.com"
    
    private var webView = WKWebView()
    
    private var backButton = UIBarButtonItem()
    private var refreshButton = UIBarButtonItem()
    private var forwardButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        loadWebPage()
    }
    
    override func loadView() {
        
        view = UIView()
        setupWebView()
    }
    
    private func setupWebView() {
        
        webView = WKWebView()
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    fileprivate func loadWebPage() {
        
        guard let url = URL(string: appHomePage) else { return }
        webView.load(URLRequest(url: url))
        
    }
    
    private func setupNavigationBar() {
        
        backButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webBack), style: .plain, target: webView, action: #selector(webView.goBack))
        refreshButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webRefresh), style: .plain, target: webView, action: #selector(webView.reload))
        forwardButton = UIBarButtonItem(image: UIImage(named: AssetConstants.webForward), style: .plain, target: webView, action: #selector(webView.goForward))
        
        navigationController?.navigationBar.barTintColor = UIColor.appColor(.navBarGreen)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItems = [backButton, refreshButton, forwardButton]
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

        backButton.isEnabled = false
        forwardButton.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
