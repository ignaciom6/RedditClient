//
//  MockRedditService.swift
//  RedditClientTests
//
//  Created by Ignacio Mariani on 06/04/2021.
//

import Foundation
@testable import RedditClient

let thumbnailUrl = "https://a.thumbs.redditmedia.com/vw5Lb2gnVmhLNH8TUGNjjS7hrXWaKh1RvpGxUe3T4e8.jpg"
let createdTimestamp = 1617544828

class MockRedditService {
    
}

extension MockRedditService: RedditServiceProtocol {
    typealias DataModelCompletion = (DataModel?, Error?) -> ()
    
    static func redditTopPosts(completion: @escaping DataModelCompletion) {
        let mockPostDataModel = PostDataModel(title: "Title",
                                              author: "Author",
                                              comments: 5,
                                              thumbnail: thumbnailUrl,
                                              created: createdTimestamp)
        let mockPostModel = PostModel(data: mockPostDataModel)
        
        let postsArray = [mockPostModel]
        
        let mockPostsDataModel = PostsDataModel(children: postsArray)
        let mockDataModel = DataModel(data: mockPostsDataModel)
        
        completion(mockDataModel, nil)
    }
}
