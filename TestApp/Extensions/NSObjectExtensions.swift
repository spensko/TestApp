//
//  NSObjectExtensions.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return type(of: self).className
    }

    static var className: String {
        return String(describing: self)
    }
    
}
