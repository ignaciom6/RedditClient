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
    @IBOutlet weak var downloadBtn: UIButton!
    
    private let viewModel = DetailViewModel()
    
    private var post: PostDataModel? {
        didSet {
            if let post = post {
                viewModel.setPropertiesValuesFromPost(post)
                refreshUI()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func refreshUI() {
        viewModel.username.bind { [weak self] username in
            self?.userNameLbl.text = username
        }
        
        viewModel.imageURL.bind { [weak self] imageURL in
            self?.postImage.load(urlString: imageURL)
        }
        
        viewModel.title.bind { [weak self] title in
            self?.titleLbl.text = title
        }
        
        viewModel.buttonHidden.bind { [weak self] buttonHidden in
            self?.downloadBtn.isHidden = buttonHidden
        }
        
    }
    
    @IBAction func downloadImage(_ sender: Any) {
        ImageSaver().writeToPhotoAlbum(image: postImage.image ?? UIImage())
    }
}

extension DetailViewController: PostSelectionDelegate {
    func postSelected(_ newPost: PostDataModel) {
        post = newPost
    }
}
