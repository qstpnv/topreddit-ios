//
//  PostTableViewCell.swift
//  topreddit
//
//  Created by Arthur Stepanov on 03.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    //MARK - Setups
    
    func setupCell(_ post: Post) {
        // title setup
        if let _title = post.title {
            titleLabel.text = _title
        } else {
            titleLabel.text = "No title"
        }
        
        // author setup
        if let _author = post.author {
            authorLabel.text = "by \(_author)"
        } else {
            authorLabel.text = "no author"
        }
        
        // thumbnail setup
        if let _thumbnail = post.thumbnail {
            thumbnailImageView.setImage(url: _thumbnail)
        } else {
            thumbnailImageView.image = #imageLiteral(resourceName: "placeholder")
        }
        
        // comments number setup
        if let _commentsCount = post.commentsCount {
            commentsCountLabel.text = "\(_commentsCount) comments"
        } else {
            commentsCountLabel.text = "0 comments"
        }
        
        // date setup
        if let _date = post.date {
            dateLabel.text = _date.toPrettyDate()
        } else {
            dateLabel.text = ""
        }
    }
}
