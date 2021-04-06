//
//  RedditClientTests.swift
//  RedditClientTests
//
//  Created by Ignacio Mariani on 02/04/2021.
//

import XCTest
@testable import RedditClient

class RedditClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataReceivedFromService() {
        let postsQuantity = self.expectation(description: "Post quantity")
        let title = self.expectation(description: "Get title")
        let author = self.expectation(description: "Get author")
        let thumbnail = self.expectation(description: "Get thumbnail")
        
        let tableViewModel = MainTableViewModel()
        let detailViewModel = DetailViewModel()
        
        tableViewModel.posts.bind {
            if $0?.count == 1 {
                postsQuantity.fulfill()
            }
        }
        
        detailViewModel.title.bind {
            if $0.caseInsensitiveCompare("Title") == .orderedSame {
                title.fulfill()
            }
        }
        
        detailViewModel.username.bind {
            if $0.caseInsensitiveCompare("Author") == .orderedSame {
                author.fulfill()
            }
        }
        
        detailViewModel.imageURL.bind {
            if $0.caseInsensitiveCompare("https://a.thumbs.redditmedia.com/vw5Lb2gnVmhLNH8TUGNjjS7hrXWaKh1RvpGxUe3T4e8.jpg") == .orderedSame {
                thumbnail.fulfill()
            }
        }
        
        DispatchQueue.main.async {
            MockRedditService.redditTopPosts() { (postsData, error) in
                do {
                    tableViewModel.setPropertiesValuesFromData(postsData: postsData!)
                }
            }
        }
        
        DispatchQueue.main.async {
            MockRedditService.redditTopPosts() { (postsData, error) in
                do {
                    let post = postsData?.data.children?.first?.data
                    detailViewModel.setPropertiesValuesFromPost(post!)
                }
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }

}
