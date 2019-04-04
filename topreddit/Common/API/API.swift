//
//  API.swift
//  topreddit
//
//  Created by Arthur Stepanov on 04.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation

class API: NSObject {
    
    static let shared = API()
    
    
    //MARK - Top Posts
    
    func getTopPosts(limit: Int = 10, after: String = "", completionHandler: @escaping (PostsResponse?)->()) {
        let stringUrl = "https://www.reddit.com/r/gaming/top.json?limit=\(limit)&after=\(after)"
        guard let url = URL(string: stringUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(nil)
            }
            
            do {
                if let _data = data {
                    let jsonData = try JSONSerialization.jsonObject(with: _data, options: []) as! Dictionary<String, Any>
                    let postsResponse = PostsResponse(with: jsonData)
                    completionHandler(postsResponse)
                }
            } catch {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
}
