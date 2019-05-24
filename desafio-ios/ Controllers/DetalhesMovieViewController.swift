//
//  DetalhesMovieViewController.swift
//  desafio-ios
//
//  Created by Victor on 18/05/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import CoreData

class DetalhesMovieViewController: UIViewController {

    @IBOutlet weak var imageMovieDetalhe: UIImageView!
    @IBOutlet weak var titleDetalheLabel: UILabel!
    @IBOutlet weak var yearDetalheLabel: UILabel!
    @IBOutlet weak var genreDetalheLabel: UILabel!
    @IBOutlet weak var overviewDetalheTextView: UITextView!
    
    var urlImage: String?
    var titulo: String?
    var ano: String?
    var genero: Array<Int>?
    var detalhesGenero: String?
    var descricao: String?
    var genres: MasterResponseGenre? //recupera id e nome do genero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleDetalheLabel.text = titulo
        self.yearDetalheLabel.text = ano
        self.genreDetalheLabel.text = "teste"
        self.overviewDetalheTextView.text = descricao
        if let image = urlImage {
            let dado = image
            print(dado)
            self.imageMovieDetalhe.sd_setImage(with: URL(string: dado), placeholderImage: #imageLiteral(resourceName: "favorite_empty_icon"), options: .handleCookies, context: nil)

        }
        self.recuperarGenero()
       // print(genero) Array Int? de genero
        self.getCompare()
        
    }
    
    func getCompare(){
        
        
    
//        for gen in genero! {
//            var generoID:Int? = gen
//
//            if genero?.contains(generoID ?? 0) ?? false {
//                print("tem o 80")
//            } else {
//                print("nao tem um dos estilos do john wick")
//            }
//           // print(generoID as Any)
//
//        }
        
    }
    
    func recuperarGenero(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=4b299949fc90bb34aebaf5ba4dc28389&language=en-US") ?? "").responseJSON { (response) in
            do {
               // print(response)
                let genres = try JSONDecoder().decode(MasterResponseGenre.self, from: response.data!)
                self.genres = genres
                print( self.genres as Any)
                
               // let totalGenero = genres.genres?.count
                
                for gen in genres.genres! {
                    let idGenero = gen.id
                    
                        for detalheDenero in self.genero! {
                            let generoID:Int? = detalheDenero
                            if generoID == idGenero {
                                if let resultado = gen.name{
                                    self.detalhesGenero = resultado
                                    print(self.detalhesGenero as Any)

                                }
                            }
                            
                        }
                   
                }
                
            }catch let erro {
                print(erro.localizedDescription)
            }
            
        }    }
    
    @IBAction func salvarFavorito(_ sender: Any) {

    }
    
}
