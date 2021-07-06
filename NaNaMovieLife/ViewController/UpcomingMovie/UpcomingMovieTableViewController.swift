//
//  UpcomingMovieTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/18.
//

import UIKit
import SVProgressHUD

class UpcomingMovieTableViewController: BaseViewController {

    @IBOutlet var viewController: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showCountryLabel: UILabel!
    @IBOutlet weak var selectCountryButton: UIButton!
    @IBOutlet weak var buttonTopToSuperViewConstraint: NSLayoutConstraint!
    var upcomingListInfo: [UpcomingListInfoResponse] = []
    var totalPage: Int?
    var nowCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let vc = CountryPickerViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showPicker(_ sender: UIButton) {
        
        let vc = CountryPickerViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func fetchUpcomingData(page: Int, region: String) {
        
        SVProgressHUD.show(withStatus: "載入中")
        // 將打api以及解析包進去 ApiWebService
        ApiWebService().fetchUpcomingMovieList(page: page, region: region) { [weak self] upcomingListResponse, totalPageResponse, error in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            if let list = upcomingListResponse {
                
                self.upcomingListInfo = list
                self.tableView.reloadData()
                self.totalPage = totalPageResponse
            } else {
                // show alert
            }
        }
    }
    
}

extension UpcomingMovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return upcomingListInfo.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 200, 0, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0

        UIView.animate(withDuration: 0.5){
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UpcomingMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie: UpcomingListInfoResponse = upcomingListInfo[indexPath.row]
        
        if let url = movie.poster_path {
            if let imageurl = URL(string: ApiWebService.kImageBaseUrl + url) {
                cell.movieImage.sd_setImage(with: imageurl, completed: nil)
            }
        }
        // 因為 cell 會 reuse，所以圖片url解包失敗也要把 movieImageView 設定成 nil
        else {
            cell.movieImage = nil
        }
        cell.movieTitle.text = movie.title
        cell.movieReleaseData.text = movie.release_date
        cell.movieIntroduction.text = movie.overview
        cell.moreAction = {
            NavigationManager.goDetailVC(id: movie.id, nav: self.navigationController)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension UpcomingMovieTableViewController: CountryPickerViewControllerDelegate {
    
    func didSelectCountry(_ countryPickerViewController: CountryPickerViewController, country: CountryPickerViewController.Country) {
        
        // 用一個變數把他接起來，之後要打Api
        nowCountry = country.region
        // assign 給 current country label
        showCountryLabel.text = country.displayName
        // 取即將上映電影列表
        fetchUpcomingData(page: 1, region: country.region)
        
        print("didSelectCountry = \(country)")

    }
   
}

