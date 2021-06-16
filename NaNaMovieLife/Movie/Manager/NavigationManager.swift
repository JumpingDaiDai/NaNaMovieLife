//
//  NavigationManager.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/15.
//

import UIKit

class NavigationManager {
    
    // MARK: GOTO
    class func goDetailVC(id: Int, nav: UINavigationController?) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "\(MovieDetailTableViewController.self)") as? MovieDetailTableViewController {
            
            vc.id = id
            
            nav?.pushViewController(vc, animated: true)
        }
        print("\(id)")
    }
}
