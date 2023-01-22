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
    
//    func gidilecek(veri: MoviesDetailModel)
//    func navigateToDetailVC(movie: MoviesDetailModel)
//    func startActivityIndicator()
//    func stopActivityIndicator()
    
}

final class MoviesMainVC: UIViewController {
    
    private let viewModel = MainViewModel()
    var detailModel = MoviesDetailViewModel()
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesSearch: UISearchBar!

    var movieTitle: String?
    var ahmet:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        viewModel.getMovies(search: moviesSearch.text!)
        
        
    }
    
}
extension MoviesMainVC: MoviesMainVCInterface {
    
    func configureTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCell")
        title = "Filmler"
    }
    
    func reloadTableView() {
        moviesTableView.reloadOnMainThread()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let gidilecekvc = segue.destination as! MoviesDetailVC
//        gidilecekvc.movie = viewModel.movieDetailsData
//
//    }
    
//    func gidilecek(veri: MoviesDetailModel){
//
//        DispatchQueue.main.async {
//            MoviesDetailVC().movie = veri
//        }
//    }
        
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
        
//        viewModel.getDetail(id: viewModel.movies[indexPath.row].imdbID!)
//        detailModel.getDetail(id: viewModel.movies[indexPath.row].imdbID!)
        
        detailModel.id = viewModel.movies[indexPath.row].imdbID!
        performSegue(withIdentifier: "toGoDetail", sender: indexPath.row)
      
        
//        viewModel.getDetail(id: viewModel.movies[indexPath.item].imdbID!)
        
    }
}
    
    



