//
//  UIImageView+LoadUrl.swift
//  NaNaLearning
//
//  Created by DaiDai on 2021/4/15.
//  Copyright © 2021 NaDaiCompany. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // block comlection: ()->()
    func load(url: URL, completion: (()->())? ) {
        
        DispatchQueue.global().async {   //非main thread負責下載資料
            // 下載圖片
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {  //main thread負責更新UI
                        // Update the UI
                        
                        // 將下載得圖片設定到UIImageView裡面
                        self.image = image
                        
                        // 執行block
                        completion?()
                    }
                }
            }
        }
    }
}
