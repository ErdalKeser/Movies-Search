//
//  MoviesManager.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import Foundation

struct MoviesModel: Decodable {
    
    let Search: [MoviesProperties]?
    
}
struct MoviesProperties: Decodable {
    
    let Title: String?
    let `Type`: String?
    let Poster: String?
    let Year: String?
    let imdbID: String?
}
