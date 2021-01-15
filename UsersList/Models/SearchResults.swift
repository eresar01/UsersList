//
//  SearchResults.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import Foundation

struct SearchResults: Codable {
    var results: [User]
    var info : Info
}

struct Info: Codable {
    var page: Int
    var results: Int
    var seed: String
    var version: String
}
