//
//  TestDataManager.swift
//  NaNaMovieLife
//
//  Created by DaiDai on 2021/5/13.
//

import UIKit

/*
 {
   "widget": {
     "debug": "on",
     "window": {
       "title": "Sample Konfabulator Widget",
       "name": "main_window",
       "width": 500,
       "height": 500
     },
     "image": {
       "src": "Images/Sun.png",
       "name": "sun1",
       "hOffset": 250,
       "vOffset": 250,
       "alignment": "center"
     },
     "text": {
       "data": "Click Here",
       "size": 36,
       "style": "bold",
       "name": "text1",
       "hOffset": 250,
       "vOffset": 100,
       "alignment": "center",
       "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
     }
   }
 }
 */


struct TestDataModel: Codable {
    var widget: Widget
    
    // way 2 : 解析成 dictionary 再轉成 object
    init(from dict: [String: AnyObject]) {
        self.widget = Widget(from: dict["widget"] as? [String: AnyObject] ?? [:])
    }
}

struct Widget: Codable {
    var debug: String
//    var window: Window
//    var image: Image
    var text: Text
    
    // way 2 : 解析成 dictionary 再轉成 object
    init(from dict: [String: AnyObject]) {
        self.debug = dict["debug"] as? String ?? ""
        self.text = Text(from: dict["text"] as? [String: AnyObject] ?? [:] )
    }
}

//struct Window: Codable {
//    var title: String
//    var name: String
//    var width: Int
//    var height: Int
//}

//struct Image: Codable {
//    var src: String
//    var name: String
//    var hOffset: Int
//    var vOffset: Int
//    var alignment: String
//}

struct Text: Codable {
    var data: String
    var size: Int
    
    // way 2 : 解析成 dictionary 再轉成 object
    init(from dict: [String: AnyObject]) {
        self.data = dict["data"] as? String ?? ""
        self.size = dict["size"] as? Int ?? 0
    }
}

class TestDataManager: NSObject {
    
    // for json decoder test
    var jsonString: String = "{\"widget\":{\"debug\":\"on\",\"window\":{\"title\":\"Sample Konfabulator Widget\",\"name\":\"main_window\",\"width\":500,\"height\":500},\"image\":{\"src\":\"Images/Sun.png\",\"name\":\"sun1\",\"hOffset\":250,\"vOffset\":250,\"alignment\":\"center\"},\"text\":{\"data\":\"Click Here\",\"size\":36,\"style\":\"bold\",\"name\":\"text1\",\"hOffset\":250,\"vOffset\":100,\"alignment\":\"center\",\"onMouseUp\":\"sun1.opacity = (sun1.opacity / 100) * 90;\"}}}"
    
    var jsonData: Data {
        return Data(jsonString.utf8)
    }
}
