//
//  HomeViewModel.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import Foundation

class HomeViewModel {
    var users = DatabaseHelper.shareInstance.fetchUser()
    var posts = DatabaseHelper.shareInstance.fetchPost()
    var tempPost: [Post]? = DatabaseHelper.shareInstance.fetchPost().reversed()
    var selectedUser: User?
    
    func createUser() {
        DatabaseHelper.shareInstance.saveUser(name: "Test User1", username: "testuser1", avatar: nil)
        DatabaseHelper.shareInstance.saveUser(name: "Test User2", username: "testuser2", avatar: nil)
        DatabaseHelper.shareInstance.saveUser(name: "Test User3", username: "testuser3", avatar: nil)
    }
    
    func createPost() {
        users = DatabaseHelper.shareInstance.fetchUser()
        for user in users {
            DatabaseHelper.shareInstance.savePost(post: "Tested created post from \(user.name ?? "")", image: nil, user: user)
        }
        posts = DatabaseHelper.shareInstance.fetchPost()
        tempPost = posts.reversed()
    }
    
    func getAllPost() {
        tempPost?.removeAll()
        tempPost = DatabaseHelper.shareInstance.fetchPost().reversed()
    }
    
    func getUserPost() {
        if let validUser = selectedUser {
            tempPost?.removeAll()
            tempPost = DatabaseHelper.shareInstance.fetchUserPost(user: validUser).reversed()
        }
    }
    
    func getPostCount() -> Int {
        if let validPost = tempPost {
            return validPost.count
        }
        return 0
    }
    
}
