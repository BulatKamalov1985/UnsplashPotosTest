//
//  RandomUnsplashModel.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 15.11.2021.
//

import Foundation

// MARK: - UnsplashRandom
struct UnsplashRandom: Decodable {
    let id: String
    let createdAt: Date
    let urls: Urls
    let downloads: Int

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case urls
        case downloads
    }
}

// MARK: - Urls
struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

