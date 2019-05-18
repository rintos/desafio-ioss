//
//  ViewController.swift
//  desafio-ios
//
//  Created by Victor on 14/05/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movies: [NSDictionary]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recuperaFilmes()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func recuperaFilmes(){
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4b299949fc90bb34aebaf5ba4dc28389&language=en-US&page=1"){
            
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                
                if erro == nil{
                    
                    if let dadosRetorno = dados{
                        
                        do{
                            let objetoJson = try JSONSerialization.jsonObject(with:  dadosRetorno, options: []) as? NSDictionary
                            
                            self.movies = objetoJson?["results"] as? [NSDictionary]
                            self.collectionView.reloadData()
                            print(self.movies!)
                            // print(objetoJson!)
                        }catch {
                            print("erro ao converter")
                        }
                    }
                } else {
                    print("erro ao consultar dados")
                }
            }
                tarefa.resume()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 00
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as! MovieCollectionViewCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let poster = movie["poster_path"] as! String
        
        let defaultImageUrl = "https://image.tmdb.org/t/p/w500"
        let movieUrl = defaultImageUrl + poster
        
        if let url = URL(string: movieUrl) {
            do{
                let data = try Data(contentsOf: url)
                celula.movieImage.image = UIImage(data: data)

            }catch let err{
                print(" Error: \(err.localizedDescription)")
            }
        }
        
        
        celula.movieTitle.text = title
        
        return celula
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dados = movies![indexPath.row]
        let posterPath = dados["poster_path"] as! String
        
        let defaultImageUrl = "https://image.tmdb.org/t/p/w500"
        let movieUrl = defaultImageUrl + posterPath

       // print(movieUrl)
        
    }
}

