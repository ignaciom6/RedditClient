//
//  DetailViewModel.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 04/04/2021.
//

import UIKit

class DetailViewModel: NSObject {
    
    var username = Box("")
    var imageURL = Box("")
    var title = Box("")
    
    override init() {
        super.init()
    }
    
    func setPropertiesValuesFromPost(_ postSelected: PostDataModel) {
        self.username.value = postSelected.author
        self.imageURL.value = postSelected.thumbnail
        self.title.value = postSelected.title
    }

}
