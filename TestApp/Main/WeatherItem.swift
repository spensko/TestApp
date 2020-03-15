//
//  WeatherItem.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import Foundation

struct WeatherItem: Codable {

    let current: Current
    let location: Location
    
    struct Location: Codable {
        let name: String
        let country: String
    }

    struct Current: Codable {
        let temperature: Int
        let humidity: Int
        let feelslike: Int
        let weatherIcons: [String]
        let weatherDescriptions: [String]
        let pressure: Int
        let windSpeed: Int
        let windDegree: Int
        let windDir: String
    }
}


