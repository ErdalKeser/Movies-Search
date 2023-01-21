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
//    private var search: String = ""
    
    
}
extension MainViewModel: MainViewModelInterface {
    
    func viewDidLoad() {
        view?.configureTableView()
        
        
    }
    func getMovies(search: String) {
        
        service.downloadMovies(search: search) { [weak self] returnedMovies in
            guard let self = self else { return }
            
            guard let returnedMovies = returnedMovies else { return }
            
            self.movies.append(contentsOf: returnedMovies)
            
            print(returnedMovies)
            
            self.view?.reloadTableView()
       
        }
    
    }
//    func getDetail(id: String){
//        service.downloadDetail(id: id) { [weak self] returnedDetail in
//            guard let self = self else { return }
//            guard let returnedDetail = returnedDetail else { return }
//            print(returnedDetail)
//            self.movieDetailsData = returnedDetail
//            self.view?.gidilecek(veri: returnedDetail)
//            self.view?.reloadTableView()
//            
//            
////            self.view?.navigateToDetailVC(movie: returnedDetail)
//            
//            
//        }
//    }
//    
}








