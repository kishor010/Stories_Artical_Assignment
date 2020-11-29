//
//  StoryDetailsViewController.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 16/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import UIKit
import WebKit

class StoryDetailsViewController: UIViewController {

    @IBOutlet weak var viewWebView: UIView!
    @IBOutlet weak var labelNoData: UILabel!
    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var details: StoriesModel?
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        print(details)
        setupWebView()
        setupSegment()
        showComments()
    }
    
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame:self.viewWebView.bounds, configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.viewWebView.addSubview(webView)
        webView.backgroundColor = .black
        webView.navigationDelegate = self
        if let strUrl = details?.url, let url = URL(string: strUrl) {
            webView.load(URLRequest(url: url))
        }
    }
    
    fileprivate func showComments() {
        if webView != nil && tableViewComments != nil {
            labelNoData.isHidden = true
            if segment.selectedSegmentIndex == 0 {
                tableViewComments.isHidden = false
                viewWebView.isHidden = true
            }
            
            else {
                tableViewComments.isHidden = true
                viewWebView.isHidden = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Utils.localizedString(forKey:Keys.storyDetails)
    }
    
    @IBAction func tappedSlider(_ sender: Any) {
        showComments()
    }
    
    private func setupSegment() {
        segment.selectedSegmentIndex = 0
        segment.setTitle(Utils.localizedString(forKey:Keys.comments), forSegmentAt: 0)
        segment.setTitle(Utils.localizedString(forKey:Keys.article), forSegmentAt: 1)
    }
}

//MARK:- Webview Delegate
extension StoryDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                if let url = navigationAction.request.url,
                    let host = url.host, !host.hasPrefix("www.google.com"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            } else {
                print("No click")
                decisionHandler(.allow)
            }
    }
    
}
