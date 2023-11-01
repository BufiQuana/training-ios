//
//  MovieCollectionViewCell.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import UIKit
import Alamofire

class MovieCollectionViewCell: UICollectionViewCell {
    private var currentRequest: DataRequest? = nil

    @IBOutlet weak var popularityMovie: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageMovie.image = nil
        self.currentRequest?.cancel()
    }

    func configure(movie: ModelMovie) {
        var popularityString : String = String(movie.popularity)
        popularityString = popularityString.replacingOccurrences(of: ".", with: "")
        let popularity = Int(popularityString) ?? 0
        
        self.titleMovie.text = movie.title
        self.popularityMovie.text = "Popularity \(popularity)"
        APIFetchHandler.shared.fetchImage(path: "https://image.tmdb.org/t/p/w1280"+movie.poster_path) { image, request in
            self.imageMovie.image = image
            self.currentRequest = request
        }
    }
}
