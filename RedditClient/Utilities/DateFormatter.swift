//
//  DateFormatter.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 05/04/2021.
//

import UIKit

class DateFormatter: NSObject {
    
    class func getPostedTimeAgo(for unixInterval: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixInterval))

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let string = formatter.localizedString(for: date, relativeTo: Date())

        return string
    }

}
