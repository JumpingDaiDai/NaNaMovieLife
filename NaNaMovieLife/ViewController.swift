//
//  ViewController.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/13.
//

import UIKit

class ViewController: UIViewController {

    var testData: TestDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // way 1 : 解析成Object
        parse_1()
        
        // way 2 : 解析成 dictionary 再轉成 object
//        parse_2()
        
        showTestModel()
    }
    
    // way 1 : 解析成Object
    func parse_1() {
        let testDataManager = TestDataManager()
        
        testData = try? JSONDecoder().decode(TestDataModel.self, from: testDataManager.jsonData)
        print("testData = \(String(describing: testData))")
    }
    
    // way 2 : 解析成 dictionary 再轉成 object
    func parse_2() {
        let testDataManager = TestDataManager()
        
        if let json = try? JSONSerialization.jsonObject(with: testDataManager.jsonData, options: []) as? [String: Any] {
            
            testData = TestDataModel(from: json as [String: AnyObject])
            print("json = \(json)")
            print("testData = \(String(describing: testData))")
        }
    }

    func showTestModel() {
        guard let testData = testData else { return }
        
        print("text's data = \(testData.widget.text.data)")
        print("text's size = \(testData.widget.text.size)")
    }
}

