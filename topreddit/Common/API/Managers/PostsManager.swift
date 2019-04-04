//
//  PostsManager.swift
//  topreddit
//
//  Created by Arthur Stepanov on 04.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation

class PostsManager: NSObject {
    
    static let shared = PostsManager()
    
    var posts: [Post]?
    
    var after = ""
    var limit = 10
    
    
    func loadTopPosts(completion: @escaping (Bool)->()) {
        API.shared.getTopPosts(limit: limit, after: after) { response in
            guard let _response = response, _response.list.count > 0 else {
                completion(false)
                return
            }
            
            if self.posts == nil {
                self.posts = [Post]()
                self.posts = _response.list
                self.after = _response.after
            } else {
                self.posts?.append(contentsOf: _response.list)
                self.after = _response.after
            }
            
            completion(true)
        }
    }
    
}
