//
//  MovieCollectionViewController.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import UIKit

class MovieCollectionViewController: UIViewController {
    
    private var listMovie: [ModelMovie] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }

    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            movieCollectionView.register(cellType: MovieCollectionViewCell.self)
            movieCollectionView.dataSource = self
            movieCollectionView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        APIFetchHandler.shared.fetchAPIDataMovie { list in
            self.listMovie = list
        }
    }
}

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 120)
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)!
        cell.configure(movie: listMovie[indexPath.row])
        return cell
    }
}
