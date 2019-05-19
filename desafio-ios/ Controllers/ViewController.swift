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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var myMovies:MasterResponse?
    
    let defaultImageUrl = "https://image.tmdb.org/t/p/w500"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDadosMovies()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as? MovieCollectionViewCell
        celula?.movieTitle.text = myMovies?.results?[indexPath.row].original_title
        let url = myMovies?.results?[indexPath.row].poster_path
        let link = defaultImageUrl + url!
        celula?.movieImage?.sd_setImage(with: URL(string: link), placeholderImage: #imageLiteral(resourceName: "favorite_empty_icon"), options: .handleCookies, context: nil)
        
        return celula!
    }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            self.collectionView.deselectItem(at: indexPath, animated: true)
            let dados = myMovies?.results?[indexPath.row].original_title
            print(dados!)
            
            //let movie:MasterResponse?
            if let viewDestiny = self.storyboard?.instantiateViewController(withIdentifier: "DetalhesMovieViewController") as? DetalhesMovieViewController {
                
                let url = myMovies?.results?[indexPath.row].poster_path
                let link = defaultImageUrl + url!
                
                viewDestiny.titulo = (myMovies?.results?[indexPath.row].original_title)!
                viewDestiny.ano = myMovies?.results?[indexPath.row].release_date
               // viewDestiny.genero = myMovies?.results?[indexPath.row].genre_ids
                viewDestiny.descricao = myMovies?.results?[indexPath.row].overview
                viewDestiny.urlImage = link
                
                self.navigationController!.pushViewController(viewDestiny, animated: true)

            }
    
        }
    
    func getDadosMovies(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4b299949fc90bb34aebaf5ba4dc28389&language=en-US&page=1") ?? "").responseJSON { (response) in
            do {
                let myMovies = try JSONDecoder().decode(MasterResponse.self, from: response.data!)
                self.myMovies = myMovies
               // print(response)
                self.collectionView.reloadData()
            }catch let erro {
                print(erro.localizedDescription)
            }
            
        }
    }
    
}

