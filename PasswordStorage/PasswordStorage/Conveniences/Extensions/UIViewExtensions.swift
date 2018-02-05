//
//  UIViewExtensions.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 02/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

fileprivate let loadingViewIdentifier = 424242

extension UIView {
    
    fileprivate func loadingView() -> UIView {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.tag = loadingViewIdentifier
        return loadingView
    }
    
    fileprivate func shadowView() -> UIView {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.darkGray
        shadowView.alpha = 0.5
        shadowView.frame = self.bounds
        return shadowView
    }
    
    fileprivate func activityIndicator() -> UIActivityIndicatorView {
        let activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = ThemeColor.shared.primaryColor
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func startLoading() {
        let view = loadingView()
        view.addSubview(shadowView())
        view.addSubview(activityIndicator())
        
        DispatchQueue.main.async {
            self.addSubview(view)
        }
    }
    
    func stopLoading() {
        let holderView = self.viewWithTag(loadingViewIdentifier)
        DispatchQueue.main.async {
            holderView?.removeFromSuperview()
        }
    }
    
    func enableLoading(_ enable: Bool) {
        if (enable) {
            startLoading()
        } else {
            stopLoading()
        }
    }
}
