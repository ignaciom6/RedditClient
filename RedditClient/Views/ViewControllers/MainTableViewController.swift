//
//  MainTableViewController.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 02/04/2021.
//

import UIKit

protocol PostSelectionDelegate: class {
  func postSelected(_ newPost: PostDataModel)
}

class MainTableViewController: UITableViewController {
    private let kCellHeight: CGFloat = 140
    private let kCellId = "PostCell"
    private let viewModel = MainTableViewModel()
    
    var posts: [PostModel] = []
    weak var delegate: PostSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.posts.bind { [weak self] posts in
            self?.posts = posts ?? []
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! PostTableViewCell

        //Testing Data Model
        let post = posts[indexPath.row].data
        cell.usernameLbl.text = post.author
        cell.titleTxtV.text = post.title
        cell.commentsLbl.text = "Comments " + String(post.comments)
        cell.postImg.load(urlString: post.thumbnail)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row].data
        delegate?.postSelected(selectedPost)
    }

}
