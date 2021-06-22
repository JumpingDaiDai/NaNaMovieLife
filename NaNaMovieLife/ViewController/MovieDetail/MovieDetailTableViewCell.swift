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
        self.selectionStyle = .none
    }
}


class RelatedMovieTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var recommendListInfo: [RecommendListInfo] = [] {
        didSet{
            self.collectionView.reloadData()
            
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return min(recommendListInfo.count, 5)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? RelatedMovieCollectionCell else {
            return UICollectionViewCell()
        }
    
        let data = recommendListInfo[indexPath.row]
        cell.movieTitleLabel.text = data.title
        if let url = data.poster_path {
            
            if let imageurl = URL(string: ApiWebService.kImageBaseUrl + url) {
                cell.movieImageView.sd_setImage(with: imageurl, completed: nil)
            }
        }
    
        return cell
    }

    

}


class RelatedMovieCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
}
