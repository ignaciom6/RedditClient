//
//  ImageSaver.swift
//  RedditClient
//
//  Created by Ignacio Mariani on 05/04/2021.
//

import UIKit

class ImageSaver: NSObject {

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved")
    }
}
