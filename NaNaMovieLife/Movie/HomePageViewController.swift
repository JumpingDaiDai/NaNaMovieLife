//
//  HomePageViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/24.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBAction func goMovieListVC(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "\(MovieListsTableViewController.self)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
