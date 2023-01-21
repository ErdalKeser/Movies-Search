//
//  MoviesDetailViewModel.swift
//  Movies-App
//
//  Created by Erdal Keser on 19.01.2023.
//

import Foundation

protocol DetailViewModelInterface {
    
    var view: MoviesDetailVCInterface? { get set }
//    func viewDidLoad()
    func getDetail()
}

final class MoviesDetailViewModel {
    
    weak var view: MoviesDetailVCInterface?
    var service = MovieService()
    var incomingData:  MoviesDetailModel?
    var id: String?
    
    
}
extension MoviesDetailViewModel: DetailViewModelInterface{
    
    func viewDidLoad() {
       
        
    }
    
    func getDetail(){
        
        guard let id = id else {return}
        
        service.downloadDetail(id: id ) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            self.incomingData = returnedDetail
            
            self.view?.configureTypeLabel()
            self.view?.configurePosterImageView()
            self.view?.configureOverviewLabel()
            self.view?.configureTitleLabel()
            
            
            
            
            print(returnedDetail)
            
            
            
            
        }
    
    
}
}
