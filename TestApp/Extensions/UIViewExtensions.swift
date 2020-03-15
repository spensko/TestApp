//
//  UIViewExtensions.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: type(of: self).className, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return nil }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
}
