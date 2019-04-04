//
//  UIImageView.swift
//  topreddit
//
//  Created by Arthur Stepanov on 03.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Set image downloaded from url to UIImageView
    func setImage(url imageUrl: String, completion: ((UIImage)->())? = nil) {
        let url = URL(string: imageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let _data = data, error == nil else { return }
            DispatchQueue.main.async() {
                guard let newImage = UIImage(data: _data) else {
                    self.image = #imageLiteral(resourceName: "placeholder")
                    return
                }
                self.image = newImage
                guard let _completion = completion else { return }
                _completion(newImage)
            }
        }
        
        task.resume()
    }
    
}
