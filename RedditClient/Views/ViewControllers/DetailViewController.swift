//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 02/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        print("Title: ", post?.title ?? "")
        print("-----")
    }
    
}

extension DetailViewController: PostSelectionDelegate {
    func postSelected(_ newPost: PostDataModel) {
        post = newPost
    }
}
