//
//  MainViewModel.swift
//  Movies-App
//
//  Created by Erdal Keser on 10.12.2022.
//

import Foundation
import UIKit


protocol MoviesViewModelInterFace {
    var view : MoviesViewInterFace? { get set }
    
    func getDataResponse(search: String)
}
class MainViewModel: NSObject{
    
    var movieListe = [MoviesProperties]()
    
    var incomingSearchText: String?
    
    let mmvc = MoviesMainVC()
    weak var view: MoviesViewInterFace?
    
    
}
extension MainViewModel: MoviesViewModelInterFace {
    func getDataResponse(search: String) {
        let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=9437def")!

        URLSession.shared.request(url: url, expecting: MoviesModel.self) { [weak self] result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.movieListe = users.Search!
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
 }
 
    
}








