//
//  ViewController.swift
//  Movies-App
//
//  Created by Erdal Keser on 12.11.2022.
//

import UIKit

//protocol ToGoData: AnyObject {
//
//    func toGoSearchText(searchText: String)
//}
protocol MoviesViewInterFace: AnyObject {
    
    func reloadData()
}

class MoviesMainVC: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesSearch: UISearchBar!
    
    var movieTitle: String?
    
    private lazy var mvm: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCell")
        title = "Movies"
        mvm.view = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let toGoDetailVC = segue.destination as! MoviesDetailVC
        toGoDetailVC.incomingMoviePoster = mvm.movieListe[indeks!].Poster
        toGoDetailVC.incomingMovieName = mvm.movieListe[indeks!].Title
        toGoDetailVC.incomingMovieType = mvm.movieListe[indeks!].Type
        toGoDetailVC.incomingMoviePlot = mvm.movieListe[indeks!].Year
        
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        
        mvm.getDataResponse(search: moviesSearch.text!)
        
    }
    
}
extension MoviesMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mvm.movieListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier:"moviesCell", for: indexPath) as! MoviesTableViewCell
        
        cell.movieName.text = mvm.movieListe[indexPath.row].Title
        cell.movieType.text = mvm.movieListe[indexPath.row].Type
        cell.moviePlot.text = mvm.movieListe[indexPath.row].Year
        if let incomindata =  mvm.movieListe[indexPath.row].Poster {
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
    
}
extension MoviesMainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toGoDetail", sender: indexPath.row)
        
    }
}
extension MoviesMainVC: MoviesViewInterFace {
    func reloadData() {
        moviesTableView.reloadData()
    }
    
}

