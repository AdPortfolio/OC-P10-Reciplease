//
//  DirectionsViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 14/08/2022.
//

import UIKit
import WebKit

final class DirectionsViewController: UIViewController , WKNavigationDelegate {
    
    // MARK: - Properties
    var viewModel: DirectionsViewModel!
    private var webView: WKWebView!
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - View Controller Life Cycle
    init(viewModel: DirectionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var comp = URLComponents(string: viewModel.recipeCellViewModel.url)
        comp?.scheme = "https"
        
        guard let http = comp?.string else {return}
        guard let url = URL(string: http) else {return}
        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupUI()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    deinit {
        print("DirectionsVC deinit")
    }
}

// MARK: - View Model Binding
extension DirectionsViewController {
    private func bind(to: DirectionsViewModel){
        viewModel.titleText = { text in
            self.title = text
        }
        
        viewModel.backButtonItemTitleUpdater = { title in
            self.navigationItem.backButtonTitle = title
        }
    }
}

// MARK: - User Interface Configuration
extension DirectionsViewController {
    private func setupUI() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
