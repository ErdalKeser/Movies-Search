//
//  MoviesDetailVC.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

class MoviesDetailVC: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var detailPlotLabel: UILabel!
    var incomingMoviePoster: String?
    var incomingMovieName: String?
    var incomingMovieType: String?
    var incomingMoviePlot: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let incomindata = self.incomingMoviePoster {
    
        let url = URL(string: incomindata)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.detailImageView.image = UIImage(data: data!)
            }
        }
        }
        detailNameLabel.text = incomingMovieName
        detailTypeLabel.text = incomingMovieType
        detailPlotLabel.text = incomingMoviePlot

    }
    
}
