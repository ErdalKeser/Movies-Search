//
//  MoviesDetailVC.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

protocol MoviesDetailVCInterface : AnyObject {
    
    func configureTitleLabel()
    func configureTypeLabel()
    func configureOverviewLabel()
    func configurePosterImageView()
    
}


final class MoviesDetailVC: UIViewController {
    
    var movie: MoviesDetailModel?
    
    private let viewModel = MoviesDetailViewModel()
    
//    init(movie: MoviesDetailModel) {
//        self.movie = movie
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var detailPlotLabel: UILabel!
    
//    var incomingMoviePoster: String?
//    var incomingMovieName: String?
//    var incomingMovieType: String?
//    var incomingMoviePlot: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
//        viewModel.viewDidLoad()
        
        viewModel.getDetail()
        
        
        guard let data = viewModel.incomingData?.Title else { return }
        detailNameLabel.text = data
        
        
        
        
//        detailNameLabel.text = incomingMovieName
//        detailTypeLabel.text = incomingMovieType
//        detailPlotLabel.text = incomingMoviePlot

    }
    
}

extension MoviesDetailVC: MoviesDetailVCInterface {
    
    func configurePosterImageView() {
        if let incomindata = movie?.Poster {
    
        let url = URL(string: incomindata)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.detailImageView.image = UIImage(data: data!)
            }
        }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let data = viewModel.incomingData?.Title else { return }
        detailNameLabel.text = data
        detailTypeLabel.text = data
    }
    
    func configureTitleLabel() {
        
    }
    
    func configureTypeLabel() {
        detailTypeLabel.text = "movie?.Year"
    }
    
    func configureOverviewLabel() {

        detailPlotLabel.text = "movie?.Plot"
    }
    
    
    
}
