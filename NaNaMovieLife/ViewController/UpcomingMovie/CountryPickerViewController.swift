//
//  CountryPickerViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/22.
//

import UIKit

protocol CountryPickerViewControllerDelegate: NSObjectProtocol {
    func doneButtonIsClick(_ countryPickerViewController: CountryPickerViewController, text: String)
}

class CountryPickerViewController: UIViewController {

    weak var delegate: CountryPickerViewControllerDelegate?
    lazy var componentText: String = country[0]
    var country: [String] = [
        "美國",
        "日本",
        "英國",
        "法國",
        "印度",
        "德國"
    ]
    @IBAction func doneButtonIsClick() {
        delegate?.doneButtonIsClick(self, text: componentText)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
}

extension CountryPickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return country[row]
    }
    
}

extension CountryPickerViewController: UIPickerViewDelegate {
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        componentText = country[row]
    }
}


