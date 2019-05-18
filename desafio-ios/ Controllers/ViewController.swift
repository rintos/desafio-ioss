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
    
    let filmes = ["Matrix","John Wick","Wolverine","DBZ"]
    let icons:[UIImage] = [
    UIImage(named: "favorite_empty_icon")!,
    UIImage(named: "favorite_full_icon")!,
    UIImage(named: "FilterIcon")!,
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recuperaFilmes()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    


    func recuperaFilmes(){
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4b299949fc90bb34aebaf5ba4dc28389&language=en-US&page=1"){
            
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                
                if erro == nil{
                    
                    if let dadosRetorno = dados{
                        
                        do{
                            let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? NSDictionary
                            
                            self.movies = objetoJson?["results"] as? [NSDictionary]
                            print(objetoJson!)
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
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as! MovieCollectionViewCell
       
        celula.movieTitle.text = filmes[indexPath.row]
        
        
        return celula
    }
}

