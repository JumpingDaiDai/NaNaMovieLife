//
//  CountryPickerViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/6/22.
//

import UIKit

protocol CountryPickerViewControllerDelegate: NSObjectProtocol {
    func didSelectCountry(_ countryPickerViewController: CountryPickerViewController, country: CountryPickerViewController.Country)
}

class CountryPickerViewController: BaseViewController {

    enum Country {
        case America
        case Japan
        case Britain
        case France
        case India
        case Germany
        
        // use for display
        var displayName: String {
            switch self {
            case .America:
                return "美國"
            case .Japan:
                return "日本"
            case .Britain:
                return "英國"
            case .France:
                return "法國"
            case .India:
                return "印度"
            case .Germany:
                return "德國"
            }
        }
        
        // use for api
        var region: String {
            switch self {
            case .America:
                return "US"
            case .Japan:
                return "JP"
            case .Britain:
                return "GB"
            case .France:
                return "FR"
            case .India:
                return "IN"
            case .Germany:
                return "DE"
            }
        }
    }
    
    weak var delegate: CountryPickerViewControllerDelegate?
    var selectCountry: Country = Country.America
    var country: [Country] = [
        .America,
        .Japan,
        .Britain,
        .France,
        .India,
        .Germany
    ]
    
    @IBAction func doneButtonIsClick() {
        delegate?.didSelectCountry(self, country: selectCountry)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        viewSetup()
    }
    
    private func viewSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePicker))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func closePicker() {
        dismiss(animated: true, completion: nil)
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
        return country[row].displayName
    }
    
}

extension CountryPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCountry = country[row]
    }
}


