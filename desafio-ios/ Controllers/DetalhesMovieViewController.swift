//
//  DetalhesMovieViewController.swift
//  desafio-ios
//
//  Created by Victor on 18/05/2019.
//  Copyright © 2019 Rinver. All rights reserved.
//

import UIKit
import SDWebImage

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
    var descricao: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleDetalheLabel.text = titulo
        self.yearDetalheLabel.text = ano
    //    self.genreDetalheLabel.text = genero
        self.overviewDetalheTextView.text = descricao
        if let image = urlImage {
            let dado = image
            print(dado)
            self.imageMovieDetalhe.sd_setImage(with: URL(string: dado), placeholderImage: #imageLiteral(resourceName: "favorite_empty_icon"), options: .handleCookies, context: nil)

        }
        //self.titleDetalheLabel.text = movieDetail?.results?(str)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func salvarFavorito(_ sender: Any) {

    }
    
}
