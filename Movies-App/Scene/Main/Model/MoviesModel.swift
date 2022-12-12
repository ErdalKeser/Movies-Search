//
//  MoviesManager.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import Foundation
struct MoviesModel: Codable {
    
    var Search: [MoviesProperties]?
    
}
struct MoviesProperties: Codable {
    
    var Title: String?
    var `Type`: String?
    var Poster: String?
    var Year: String?
}
