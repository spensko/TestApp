//
//  WeatherViewModel.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

class WeatherViewModel {

    private(set) var weatherItems: [WeatherItem] = []
    
    func getWeather(query: String? = nil, completion: ((_ error: TestError?) -> Void)? = nil) {
        guard let query = query, !query.isEmpty else {
            weatherItems = []
            completion?(.none)
            return
        }
        
        NetworkManager.shared.getWeather(query: query) { [weak self] response in
            guard response.error == nil else {
                self?.weatherItems = []
                completion?(response.error)
                return
            }
            
            if let data = response.result, let item = try? data.decode(as: WeatherItem.self) {
                self?.weatherItems = [item]
            }
            completion?(.none)
        }
    }
}
