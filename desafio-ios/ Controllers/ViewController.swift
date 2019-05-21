//
//  ViewController.swift
//  desafio-ios
//
//  Created by Victor on 14/05/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    var myMovies: MasterResponse?
    var currentMovies: MasterResponse?
    
    let defaultImageUrl = "https://image.tmdb.org/t/p/w500"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchMovies: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        self.getDadosMovies()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.keyboardDismissMode = .onDrag
        self.collectionView.reloadData()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/2)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getDadosMovies()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as? MovieCollectionViewCell
        celula?.movieTitle.text = currentMovies?.results?[indexPath.row].original_title
        let url = currentMovies?.results?[indexPath.row].poster_path
        let link = defaultImageUrl + url!
        celula?.movieImage?.sd_setImage(with: URL(string: link), placeholderImage: #imageLiteral(resourceName: "favorite_empty_icon"), options: .handleCookies, context: nil)
        
        return celula!
    }
    
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            self.collectionView.deselectItem(at: indexPath, animated: true)
            let dados = currentMovies?.results?[indexPath.row].original_title
            print(dados!)
            
            //let movie:MasterResponse?
            if let viewDestiny = self.storyboard?.instantiateViewController(withIdentifier: "DetalhesMovieViewController") as? DetalhesMovieViewController {
                
                let url = currentMovies?.results?[indexPath.row].poster_path
                let link = defaultImageUrl + url!
                
                viewDestiny.titulo = (currentMovies?.results?[indexPath.row].original_title)!
                viewDestiny.ano = currentMovies?.results?[indexPath.row].release_date
               // viewDestiny.genero = myMovies?.results?[indexPath.row].genre_ids
                viewDestiny.descricao = currentMovies?.results?[indexPath.row].overview
                viewDestiny.urlImage = link
                
                self.navigationController!.pushViewController(viewDestiny, animated: true)

            }
    
        }
    

    func getDadosMovies(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4b299949fc90bb34aebaf5ba4dc28389&language=en-US&page=1") ?? "").responseJSON { (response) in
            do {
                let myMovies = try JSONDecoder().decode(MasterResponse.self, from: response.data!)
                self.myMovies = myMovies
                self.currentMovies = myMovies
                print(response)
                self.collectionView.reloadData()
            }catch let erro {
                print(erro.localizedDescription)
            }
            
        }
    }
    
    private func setUpSearchBar(){
        searchMovies.delegate = self
    }
    //Search Movies
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard  !searchText.isEmpty  else {
            currentMovies?.results = myMovies?.results
             self.collectionView.reloadData()
            return
        }
        
        currentMovies?.results = myMovies?.results?.filter({ (MasterResponse) -> Bool in
            ((MasterResponse.original_title?.lowercased().contains(searchText.lowercased()))!)
        })
        self.collectionView.reloadData()
    }
    
}
