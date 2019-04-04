//
//  Post.swift
//  topreddit
//
//  Created by Arthur Stepanov on 03.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation

class Post: NSObject {
    
    var title: String?
    var author: String?
    var date: TimeInterval?
    var thumbnail: String?
    var fullsizedImage: String?
    var commentsCount: Int?
    
    init(with dictionary: [String: Any]?) {
        guard let _dictionary = dictionary else { return }
        title = _dictionary["title"] as? String
        author = _dictionary["author"] as? String
        date = _dictionary["created"] as? TimeInterval
        thumbnail = _dictionary["thumbnail"] as? String
        fullsizedImage = _dictionary["url"] as? String
        commentsCount = _dictionary["num_comments"] as? Int
    }
    
}
