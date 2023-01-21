//
//  MovieService.swift
//  Movies-App
//
//  Created by Erdal Keser on 19.01.2023.
//

import Foundation

final class MovieService {

    func downloadMovies(search: String, completion: @escaping ([MoviesProperties]?) -> ()) {
        guard let url = URL(string: APIURLs.movies(search: search)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func downloadDetail(id: String, completion: @escaping (MoviesDetailModel?) -> ()) {
        guard let url = URL(string: APIURLs.detail(id: id)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handleWithData(_ data: Data) -> [MoviesProperties]? {
        do {
            let movie = try JSONDecoder().decode(MoviesModel.self, from: data)
            return movie.Search
        }catch {
            print(error)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> MoviesDetailModel? {
        
        do {
            let movieDetail = try JSONDecoder().decode(MoviesDetailModel.self, from: data)
            
            return movieDetail
        } catch {
            print(error)
            return nil
        }
        
    }
}
