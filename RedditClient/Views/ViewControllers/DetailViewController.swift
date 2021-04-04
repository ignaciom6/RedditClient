//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 02/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    private var post: PostDataModel? {
        didSet {
            refreshUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func refreshUI() {
        //TODO
        userNameLbl.text = post?.author
        postImage.load(urlString: post?.thumbnail ?? "")
        titleLbl.text = post?.title
    }
    
}

extension DetailViewController: PostSelectionDelegate {
    func postSelected(_ newPost: PostDataModel) {
        post = newPost
    }
}
