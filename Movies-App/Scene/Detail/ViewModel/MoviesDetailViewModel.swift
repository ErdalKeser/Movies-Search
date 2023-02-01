//
//  MoviesDetailViewModel.swift
//  Movies-App
//
//  Created by Erdal Keser on 19.01.2023.
//

import Foundation


protocol DetailViewModelInterface {
    
    func getDetail()
    var delegate: MoviesDetailViewModelDelegate? { get set } 
}

final class MoviesDetailViewModel {
    
    weak var delegate: MoviesDetailViewModelDelegate?
    var service = MovieService()
    var incomingData:  MoviesDetailModel?
    var id: String?
    
}
extension MoviesDetailViewModel: DetailViewModelInterface{
    
    func getDetail(){
        
        guard let id = id else {return}
        
        service.downloadDetail(id: id ) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            self.incomingData = returnedDetail
            self.delegate?.showDetails()
        }
    }
}
