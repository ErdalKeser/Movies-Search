//
//  MoviesDetailVC.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

protocol MoviesDetailViewModelDelegate: AnyObject {
    func showDetails()
}

final class MoviesDetailVC: UIViewController {
        
    let viewModel = MoviesDetailViewModel()
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var detailPlotLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel.getDetail()
        
        viewModel.delegate = self
    
    }

}

extension MoviesDetailVC: MoviesDetailViewModelDelegate {
    
    func showDetails() {
        guard let data = viewModel.incomingData else { return }
        DispatchQueue.main.async {
            self.detailNameLabel.text = data.Title
            self.detailTypeLabel.text = data.Actors
            self.detailPlotLabel.text = data.Plot

            if let url = URL(string: data.Poster ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }

                    DispatchQueue.main.async { /// execute on main thread
                        self.detailImageView.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
        }
    }
}
