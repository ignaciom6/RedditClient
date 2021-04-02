//
//  PostTableViewCell.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 02/04/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postViewedImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postedTimeLbl: UILabel!
    @IBOutlet weak var titleTestView: UITextView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var commentsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
