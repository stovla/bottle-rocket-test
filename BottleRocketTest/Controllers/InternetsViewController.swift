//
//  InternetsViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 03/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit
import WebKit

class InternetsViewController: UIViewController {

    let webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private var websites = ["https://www.bottlerocketstudios.com"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        
        setupWebView()
        setupNavigationBarItems()
    }
    
    private func setupWebView() {
        
        let back = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: webView, action: #selector(webView.goBack))
        let refresher = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .plain, target: webView, action: #selector(webView.reload))
        let forward = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: webView, action: #selector(webView.goForward))
        
        navigationItem.leftBarButtonItems = [back, refresher, forward]
        
        
    }
    
    private func setupNavigationBarItems() {
        
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
