//
//  AlertViewController.swift
//  topreddit
//
//  Created by Arthur Stepanov on 04.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    let waitingHolderView = UIView()
    let waitingIndicator = UIActivityIndicatorView()
    
    
    //MARK - Waiting Indicator
    
    func showWaiting() {
        waitingHolderView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        waitingHolderView.center = view.center
        waitingHolderView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.7)
        waitingHolderView.clipsToBounds = true
        waitingHolderView.layer.cornerRadius = 10
        
        waitingIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        waitingIndicator.center = CGPoint(x: waitingHolderView.frame.size.width / 2, y: waitingHolderView.frame.size.height / 2);
        waitingIndicator.style = .whiteLarge
        
        waitingHolderView.addSubview(waitingIndicator)
        view.addSubview(waitingHolderView)
        
        waitingIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideWaiting() {
        DispatchQueue.main.async {
            self.waitingIndicator.removeFromSuperview()
            self.waitingHolderView.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
    //MARK - Title Alert
    
    func showOkayAlert(title: String? = nil, text: String? = nil) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}
