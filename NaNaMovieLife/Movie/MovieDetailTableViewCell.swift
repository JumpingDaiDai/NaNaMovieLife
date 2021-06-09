//
//  MovieDetailTableViewCell.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/2.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var originalTitleLable: UILabel!
    @IBOutlet weak var releaseDataLable: UILabel!
    @IBOutlet weak var runtimeLable: UILabel!
    @IBOutlet weak var averageScoreLable: UILabel!
    @IBOutlet weak var commentCountLable: UILabel!
    @IBOutlet weak var overviewLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


class RelatedMovieTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    
//    @IBOutlet weak var colletionView: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! RelatedMovieCollectionCell
    
        
    
        return cell
    }

    

}


class RelatedMovieCollectionCell: UICollectionViewCell {
    
}
