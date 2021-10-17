//
//  User.swift
//  SocialProject
//
//  Created by Irina Kuligina on 10.06.2021.
//

import UIKit

protocol CellModel {
    var image: UIImage { get set }
    var name: String { get set }
    var isAdded: Bool  { get set }
}

struct User: CellModel {
    let id: Int
    
    var image: UIImage
    var name: String
    var isAdded: Bool
    
    //var posts: [Post]
    
    static func changeUserAdded(by id: Int) {
        for i in 0..<database.count {
            if database[i].id == id {
                database[i].isAdded = !database[i].isAdded
            }
        }
    }
    
    static func getUser(by id: Int) -> User? {
        var result: User? = nil
        for user in database {
            if user.id == id {
                result = user
                break
            }
        }
        
        return result
    }
    
    static var database: [User] = [
        User(id: 0, image: UIImage(named: "profile1")!, name: "Иван Иванов", isAdded: true),
                                        
        User(id: 1, image: UIImage(named: "profile2")!, name: "Мария Иванова", isAdded: true),
        
        User(id: 2, image: UIImage(named: "profile3")!, name: "Николай Сидоров", isAdded: true),
        
        User(id: 3, image: UIImage(named: "profile3")!, name: "Леонид Харламов", isAdded: true)
    ]
}

