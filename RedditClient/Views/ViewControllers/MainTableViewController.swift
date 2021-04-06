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
        self.tableView.remembersLastFocusedIndexPath = true
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        
        viewModel.posts.bind { [weak self] posts in
            self?.posts = posts ?? []
            self?.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
        
        viewModel.error.bind { [weak self] error in
            if !error.isEmpty {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                        self?.dismiss(animated: true, completion: nil)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func pullToRefresh(sender:AnyObject)
    {
        viewModel.getRedditPosts()
    }
    
    @IBAction func dismissAllCells(_ sender: Any) {
        posts.removeAll()
        tableView.reloadData()
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

        let post = posts[indexPath.row].data
        
        cell.usernameLbl.text = post.author
        cell.titleTxtV.text = post.title
        cell.commentsLbl.text = "Comments " + String(post.comments)
        cell.postImg.load(urlString: post.thumbnail)
        cell.postViewedImg.isHidden = LocalData.dataExist(thumbnailUrl: post.thumbnail)
        cell.postedTimeLbl.text = DateFormatter.getPostedTimeAgo(for: post.created)
        cell.postCell = {
            self.posts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        currentCell.postViewedImg.isHidden = true
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row].data
        delegate?.postSelected(selectedPost)
        
        LocalData.save(thumbnailUrl: selectedPost.thumbnail)
    }

}
