//
//  File.swift
//  training-ios
//
//  Created by Bui Trung Quan on 18/10/2023.
//

import Foundation

struct Movie {
    let image: String
    let nameMovie: String
    let star: Int
    let author: String
    let category: String
    let numView: Int
    
    init(image: String, nameMovie: String, star: Int, author: String, category: String, numView: Int) {
        self.image = image
        self.nameMovie = nameMovie
        self.star = star
        self.author = author
        self.category = category
        self.numView = numView
    }
}

let dataExample: [Movie] = [
    Movie(image: "movie", nameMovie: "Movie 1", star: 0, author: "Author 1", category: "Category 1", numView: 100),
    Movie(image: "movie_2", nameMovie: "Movie 2", star: 3, author: "Author 2", category: "Category 2", numView: 434),
    Movie(image: "movie", nameMovie: "Movie 3", star: 2, author: "Author 3", category: "Category 3", numView: 321),
    Movie(image: "movie_2", nameMovie: "Movie 4", star: 5, author: "Author 4", category: "Category 4", numView: 14285),
    Movie(image: "movie", nameMovie: "Movie 5", star: 4, author: "Author 1", category: "Category 5", numView: 5321),
    Movie(image: "movie_2", nameMovie: "Movie 6", star: 0, author: "Author 2", category: "Category 6", numView: 231),
    Movie(image: "movie", nameMovie: "Movie 7", star: 1, author: "Author 3", category: "Category 7", numView: 221),
    Movie(image: "movie_2", nameMovie: "Movie 8", star: 3, author: "Author 4", category: "Category 8", numView: 548),
    Movie(image: "movie", nameMovie: "Movie 9", star: 5, author: "Author 1", category: "Category 9", numView: 64921),
    Movie(image: "movie_2", nameMovie: "Movie 10", star: 4, author: "Author 2", category: "Category 10", numView: 4958)
    ]
