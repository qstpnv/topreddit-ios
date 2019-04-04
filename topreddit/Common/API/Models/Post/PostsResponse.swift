//
//  PostsResponse.swift
//  topreddit
//
//  Created by Arthur Stepanov on 04.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation

class PostsResponse: NSObject {
    
    var after: String = ""
    var list: [Post] = []
    
    init(with dictionary: [String: Any]?) {
        guard let _dictionary = dictionary else { return }
        let response = _dictionary["data"] as! Dictionary<String, Any>
        after = response["after"] as! String
        let children = response["children"] as! [Dictionary<String, Any>]
        for item in children {
            let data = item["data"] as! Dictionary<String, Any>
            let post = Post(with: data)
            list.append(post)
        }
    }
    
}
