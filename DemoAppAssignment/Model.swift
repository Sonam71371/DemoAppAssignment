//
//  Model.swift
//  DemoAppAssignment
//
//  Created by Sonam Kumari on 31/01/25.
//

import Foundation

//For Auth
struct LoginResponse: Codable {
    let token_type: String
    let access_token: String
}


//for Albums
struct SportifyAlbums: Decodable {
    let albums : Albums
}

struct Albums : Decodable {
    let total : Int?
    let items : [Items]
}
struct Artists : Decodable {
    let href : String?
    let id : String?
    let name : String?
    let type : String?
}

struct Items : Decodable,Identifiable, Equatable {
    let album_type : String?
    let href : String?
    let id : String?
    let images : [Images]?
    let name : String?
    let type : String?
    let external_urls : External_urls?
    let artists : [Artists]?
    
    static func == (lhs: Items, rhs: Items) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Images : Decodable {
    let height : Int?
    let url : String?
    let width : Int?
}

struct External_urls : Decodable {
    let spotify : String?
}

//For Artist
struct ArtistResponse : Decodable {
    let artists : [Items]
}


// Item model
struct Item: Identifiable {
    let name: String
    var id: Int
}

// Section model
struct SectionData: Identifiable {
    let title: String
    let items: [Item]
    var id: Int
}
