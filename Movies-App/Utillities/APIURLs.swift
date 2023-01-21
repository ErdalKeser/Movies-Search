//
//  APIURLs.swift
//  Movies-App
//
//  Created by Erdal Keser on 19.01.2023.
//

import Foundation

enum APIURLs {
    static func movies(search: String) -> String {
        "https://www.omdbapi.com/?s=\(search)&apikey=9437def"
    }
    
    static func detail(id: String) -> String {
        "https://www.omdbapi.com/?i=\(id)&apikey=9437def"
    }
}
