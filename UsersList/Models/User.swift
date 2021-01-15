//
//  User.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import Foundation

struct User: Codable {
    var gender: String
    var name : Name
    var location: Location
    var phone: String
    var picture: Picture
    var login : Login
    //var id: id
    var isFavourite : Bool?
}

struct Name: Codable {
    var title: String
    var first: String
    var last: String
}

struct Location: Codable {
    var street : Street
    var city: String
    var state: String
    var country: String
    var coordinates: Coordinates
}

struct Coordinates: Codable {
    var latitude: String
    var longitude: String
}

struct Street: Codable {
    var number: Int
    var name: String
}

struct Picture: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}

struct id : Codable {
    var name : String
    var value: String?
}

struct Login: Codable {
    var uuid: String
}

struct Person {
    var user: User
    
    var name : String {
        return user.name.first + " " + user.name.last
    }
    var genderAndPhone: String {
        return user.gender + ", " + user.phone
    }
    var country: String {
        return user.location.country
    }
    var address: String {
        return "\(user.location.street.number) \(user.location.street.name)"
    }
    var picture: String {
        return user.picture.large
    }
    var coordinates: LocationUser {
        let location = LocationUser(latitude: Double(user.location.coordinates.latitude) ?? 0,
                                longitude: Double(user.location.coordinates.longitude) ?? 0)
        return location
    }
    var id : String {
        return user.login.uuid
    }
    var isFavourite : Bool {
        set {
            user.isFavourite = newValue
        }
        get {
            guard let favourite = user.isFavourite else {
                return false
            }
            return favourite
        }
    }
}

struct LocationUser {
    var latitude: Double
    var longitude: Double
}
