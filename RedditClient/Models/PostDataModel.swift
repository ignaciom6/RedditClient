//
//  PostDataModel.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 03/04/2021.
//

import Foundation

struct PostDataModel: Codable {
    var title: String
    var author: String
    var comments: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case comments = "num_comments"
    }
}
