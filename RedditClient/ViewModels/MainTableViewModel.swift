//
//  MainTableViewModel.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 04/04/2021.
//

import UIKit

class MainTableViewModel: NSObject {
    
    var posts: Box<[PostModel]?> = Box(nil)
    var error = Box("")
    
    override init() {
        super.init()
        getRedditPosts()
    }
    
    func getRedditPosts() {
        RedditService.redditTopPosts() { [weak self] (postsData, error) in
            guard let self = self else {return}
            guard let postsData = postsData else {
                self.error.value = error?.localizedDescription ?? "Error"
                return
            }
            self.setPropertiesValuesFromData(postsData: postsData)
        }
    }
    
    func setPropertiesValuesFromData(postsData: DataModel) {
        self.posts.value = postsData.data.children
    }

}
