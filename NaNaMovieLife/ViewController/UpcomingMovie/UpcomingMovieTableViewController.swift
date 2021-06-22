//
//  UpcomingMovieTableViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/18.
//

import UIKit

class UpcomingMovieTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func showPicker(_ sender: UIButton) {
        
        let vc = CountryPickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension UpcomingMovieTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UpcomingMovieTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
