//
//  LocalData.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 05/04/2021.
//

import UIKit

class LocalData: NSObject {
    
    class func save(thumbnailUrl: String) {
        UserDefaults.standard.set(true, forKey: thumbnailUrl)
    }
    
    class func dataExist(thumbnailUrl: String) -> Bool {
        return UserDefaults.standard.bool(forKey: thumbnailUrl)
    }

}
