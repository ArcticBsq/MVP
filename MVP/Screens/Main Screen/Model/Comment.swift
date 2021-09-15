//
//  Person.swift
//  MVP
//
//  Created by Илья Москалев on 15.09.2021.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}

typealias Comments = [Comment]
