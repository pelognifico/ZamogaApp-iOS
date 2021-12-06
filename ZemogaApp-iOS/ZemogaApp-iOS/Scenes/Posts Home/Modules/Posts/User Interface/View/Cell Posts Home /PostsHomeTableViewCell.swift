//
//  PostsHomeTableViewCell.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import UIKit
import Kingfisher

class PostsHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    static let reuseIdentifier = "postsViewCell"
    static let cellHeight: CGFloat = 64
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configUI(posts: PostsHomeModel.Posts.Response, state: Bool, favorite: Bool) {
        if state && !posts.isSelected {
            indicatorImageView.isHidden = false
        } else if posts.isFavorite == true {
            indicatorImageView.isHidden = false
            indicatorImageView.image = UIImage(named: "favorite")
        } else {
            indicatorImageView.isHidden = true
            indicatorImageView.image = UIImage(named: "circle")
        }
        
        descriptionLabel.text = posts.title
    }
    
}
