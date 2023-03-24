//
//  DatabaseHelper.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveUser(name: String, username: String, avatar: Data?) {
        let userInstance = User(context: context)
        userInstance.name = name
        userInstance.username = username
        userInstance.avatar = avatar
        do {
            try context.save()
            print("user is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func savePost(post: String, image: Data?, user: User, successBlock: (() -> Swift.Void)? = nil) {
        let postInstance = Post(context: context)
        postInstance.post = post
        postInstance.image = image
        user.addToPost(postInstance)
        do {
            try context.save()
            successBlock!()
            print("post is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUser() -> [User] {
        var fetchingUser = [User]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            fetchingUser = try context.fetch(fetchRequest) as! [User]
        } catch {
            print("Error while fetching the user")
        }
        return fetchingUser
    }
    
    func fetchPost() -> [Post] {
        var fetchingPost = [Post]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            fetchingPost = try context.fetch(fetchRequest) as! [Post]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingPost
    }
    
    func fetchUserPost(user: User) -> [Post] {
        var fetchingPost = [Post]()
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.predicate = NSPredicate(format: "user = %@", user)
        do {
            fetchingPost = try context.fetch(request)
          } catch let error {
            print("Error fetching songs \(error)")
          }
        return fetchingPost
    }
}
