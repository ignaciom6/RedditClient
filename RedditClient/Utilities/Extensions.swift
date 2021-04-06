//
//  Extensions.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 04/04/2021.
//

import Foundation
import UIKit

var cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlString: String) {
        if let image = cache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        if url == URL(string: "self") {
            self.image = nil
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cache.setObject(image, forKey: urlString as NSString)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
