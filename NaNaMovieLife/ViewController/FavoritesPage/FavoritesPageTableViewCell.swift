//
//  FaveritesPageTableViewCell.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/25.
//

import UIKit

class FavoritesPageTableViewCell: UITableViewCell {

    var moreAction: (()->Void)?
    var favoritesAction: (()->Void)?
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieInduction: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func goMovieDetailVC(_ sender: UIButton) {
        moreAction?()
    }
    @IBAction func addInFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        favoritesAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
