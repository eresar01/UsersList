//
//  DataRepository.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import Foundation


protocol SearchDataDelegate {
    func getData(result data: SearchResults)
}

protocol LoadeDataDelegate {
    func getUsersData(index: Int)
}

protocol SelectOfRow {
    func getSelect(id: String)
}

protocol SavedUser {
    func getUser(id: String, isFavourite: Bool)
}

class DataRepository {
    
    var datasource = Datasource()
    func call(page: Int) {
        datasource.searchRecuest(page: page)
    }
}
