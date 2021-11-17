//
//  SearchResultsModel.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 14.11.2021.
//

import Foundation

struct ResultsModel: Decodable {
    let total: Int?
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int?
    let height: Int?
    let urls: [URLKing.RawValue : String]
    let created_at: String?
    let user: AboutUser
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct AboutUser: Decodable {
    let name: String
}
