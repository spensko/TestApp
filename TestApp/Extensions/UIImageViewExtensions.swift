//
//  UIImageViewExtensions.swift
//  TestApp
//
//  Created by Mikhail Serov on 15.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(url: String?) {
        guard let strUrl = url, let url = URL(string: strUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }).resume()
    }
    
}


