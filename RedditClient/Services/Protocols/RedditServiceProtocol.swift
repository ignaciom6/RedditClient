//
//  RedditServiceProtocol.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 06/04/2021.
//

import Foundation

protocol RedditServiceProtocol {
    typealias DataModelCompletion = (DataModel?, Error?) -> ()
    
    static func redditTopPosts(completion: @escaping DataModelCompletion)
}
