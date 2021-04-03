//
//  RedditService.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 03/04/2021.
//

import Foundation

class RedditService {
    typealias DataModelCompletion = (DataModel?, Error?) -> ()
    
    //https://www.reddit.com/top/.json?limit=1
    
    private static let kHost = "www.reddit.com"
    private static let kPath = "/top/.json"
    private static let kLimitQI = "limit"
    private static let kLimitVal = "50"
    
    static func redditTopPosts(completion: @escaping DataModelCompletion) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = kHost
        urlBuilder.path = kPath
        urlBuilder.queryItems = [URLQueryItem(name: kLimitQI, value: kLimitVal)]
        
        guard let url = urlBuilder.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let postsDataModel: DataModel = try decoder.decode(DataModel.self, from: data)
                    completion(postsDataModel, error)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
