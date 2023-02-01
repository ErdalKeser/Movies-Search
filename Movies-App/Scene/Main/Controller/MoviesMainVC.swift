//
//  ViewController.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

protocol MoviesMainVCInterface: AnyObject {
    
    func configureTableView()
    func reloadTableView()
    func alert()
    func startActivityIndicator()
    func stopActivityIndicator()
    
}

final class MoviesMainVC: UIViewController {
    
    private let viewModel = MainViewModel()
    var detailModel = MoviesDetailViewModel()
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesSearch: UISearchBar!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var movieTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        indicator.isHidden = true
        
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        viewModel.getMovies(search: moviesSearch.text!)
        
    }
    
}
extension MoviesMainVC: MoviesMainVCInterface {
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Movie not found", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicator() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
        
    }
    
    
    func configureTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCell")
        title = "Filmler"
    }
    
    func reloadTableView() {
        moviesTableView.reloadOnMainThread()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekvc = segue.destination as! MoviesDetailVC
        gidilecekvc.viewModel.id = viewModel.id

    }
    
}

extension MoviesMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier:"moviesCell", for: indexPath) as! MoviesTableViewCell
        
        cell.movieName.text = viewModel.movies[indexPath.row].Title
        cell.movieType.text = viewModel.movies[indexPath.row].Type
        cell.moviePlot.text = viewModel.movies[indexPath.row].Year
        if let incomindata =  viewModel.movies[indexPath.row].Poster {
            if let url = URL(string: incomindata){
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let id = viewModel.movies[indexPath.row].imdbID else { return }
        viewModel.id = id
        performSegue(withIdentifier: "toGoDetail", sender: indexPath.row)
        
    }
}
    
    



