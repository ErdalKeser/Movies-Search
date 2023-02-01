//
//  MainViewModel.swift
//  Movies-App
//
//  Created by Erdal Keser on 10.12.2022.
//


import Foundation
protocol MainViewModelInterface {
    
    var view: MoviesMainVCInterface? { get set }
    
    func viewDidLoad()
    func getMovies(search:String)
}

final class MainViewModel {
    
    var movieDetailsData: MoviesDetailModel?
    
    weak var view: MoviesMainVCInterface?
    private let service = MovieService()
    var movies: [MoviesProperties] = []
    var id: String?
    
}
extension MainViewModel: MainViewModelInterface {
    
    func viewDidLoad() {
        view?.configureTableView()
        
    }
    func getMovies(search: String) {
        DispatchQueue.main.async {
            self.view?.startActivityIndicator()
        }
        
        service.downloadMovies(search: search) { [weak self] returnedMovies in
            guard let self = self else { return }
            
            guard let returnedMovies = returnedMovies else { return }
            
            self.movies.append(contentsOf: returnedMovies)
            
            if returnedMovies == nil {
                self.view?.alert()
            }
            if returnedMovies != nil {
                self.view?.stopActivityIndicator()
                
            }
            
            self.view?.reloadTableView()
            
        }
        
    }
    
}








