//
//  Post.swift
//  topreddit
//
//  Created by Arthur Stepanov on 03.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    var title: String? //title
    var author: String? //author
    var date: TimeInterval? //created (timestamp)
    var thumbnail: String? //thumbnail
    var fullsizedImage: String? //url
    var commentsCount: Int? //num_comments
    
}
