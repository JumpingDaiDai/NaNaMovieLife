//
//  MovieListsTableViewCell.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/14.
//

import UIKit

// way 3 使用 cell model 設定
// 給這個Cell用的model
struct MovieListCellModel {
    var imageName: String?
    var title: String
    var introduction: String
}

// way 4 使用 protocol 設定
protocol MovieListsTableViewCellDataSource {
    var imageName: String? { get }
    var movieTitle: String { get }
    var introduction: String { get }
}

class MovieListsTableViewCell: UITableViewCell {
    
    // way 1 基本 設定
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIntroductionLabel: UILabel!
  
    
    // more button 的點擊事件處理
    var moreAction: (()->Void)?
    
    
    @IBAction func moreInfoButtonClick(_ sender: UIButton) {
        moreAction?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    // way 2 使用 model 設定 
    func cellConfiguration(popularListInfo: PopularListInfo) {
        
        movieTitleLabel.text = popularListInfo.title
        movieIntroductionLabel.text = popularListInfo.overview
    }
    
    // way 3 使用 cell model 設定
    func cellConfiguration(cellModel: MovieListCellModel) {

        movieTitleLabel.text = cellModel.title
        movieIntroductionLabel.text = cellModel.introduction
    }
    
    // way 4 使用 protocol 設定
    func cellConfiguration(data: MovieListsTableViewCellDataSource) {
        
        movieTitleLabel.text = data.movieTitle
        movieIntroductionLabel.text = data.introduction
    }
}

// way 4 使用 protocol 設定
extension PopularListInfo: MovieListsTableViewCellDataSource {
    var imageName: String? {
        return nil
    }
    
    var movieTitle: String{
        return title
    }
    
    var introduction: String {
        return overview
    }
}
