//
//  Model.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import Foundation
import FirebaseAppCheck
import FirebaseCore

struct TokenInstagram: Codable {
    let access_token: String
}

struct UserInstagram: Codable {
    let username: String
}

struct UserZalo: Codable {
    let name: String
    let picture: DataPictureZalo
}

struct DataPictureZalo: Codable {
    let data: URLPictureZalo
}

struct URLPictureZalo: Codable {
    let url: String
}

struct ResultUser: Codable {
    let data: [User]
}

struct User: Codable {
    let id: String?
    let firstName: String
    let lastName: String
    let email: String?
}

struct Model:Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
struct ResultMovie: Codable {
    let results: [ModelMovie]
}
struct ModelMovie: Codable {
    let overview: String
    let title: String
    let backdrop_path: String
    let poster_path: String
    let popularity: Double
}
