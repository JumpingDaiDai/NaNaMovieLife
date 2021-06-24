//
//  BaseViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("開啟: \(type(of: self))")
    }
}
