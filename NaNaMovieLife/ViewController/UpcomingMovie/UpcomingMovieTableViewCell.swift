//
//  UpcomingMovieTableViewCell.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/18.
//

import UIKit

class UpcomingMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseData: UILabel!
    @IBOutlet weak var movieIntroduction: UILabel!
    
    var moreAction: (()->Void)?
    var favoriteAction: (()->Void)?
    @IBAction func moreButtonIsClick(_ sender: UIButton) {
        moreAction?()
    }
    @IBAction func favoriteBottonIsClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        favoriteAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
