//
//  AddPostViewModel.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import Foundation
import UIKit

class AddPostViewModel {
    func publishPost(post: String?, image: UIImage?, user: User?, onCompletion: (() -> Swift.Void)? = nil) {
        if let validPost = post, let validImage = image, let validUser = user {
            DatabaseHelper.shareInstance.savePost(post: validPost, image: validImage.pngData(), user: validUser, successBlock: {
                onCompletion!()
            })
        }
        
    }
}
