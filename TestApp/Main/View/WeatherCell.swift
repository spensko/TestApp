//
//  WeatherCell.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var humidity: UILabel!
    @IBOutlet private weak var feelsLike: UILabel!
    @IBOutlet private weak var location: UILabel!
    @IBOutlet private weak var pressure: UILabel!
    @IBOutlet private weak var windIcon: UIImageView!
    @IBOutlet private weak var windSpeed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherIcon.layer.cornerRadius = 2
        windIcon.layer.cornerRadius = 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherIcon.image = nil
    }
    
    func setup(with item: WeatherItem) {
        weatherIcon.setImage(url: item.current.weatherIcons.first)
        location.text = [item.location.name, item.location.country].joined(separator: ", ")
        weatherDescription.text = item.current.weatherDescriptions.compactMap({ $0 }).joined(separator: ", ")
        temperature.text = "\(item.current.temperature)°"
        feelsLike.text = "\(item.current.feelslike)°"
        humidity.text = "\(item.current.humidity)%"
        let hgPressure = Float(item.current.pressure) / 1.333
        pressure.text = "\(String(format: "%.2f", hgPressure)) mm Hg"
        let windSpeedConverted = Float(item.current.windSpeed) / 3.6
        windSpeed.text = "\(String(format: "%.1f", windSpeedConverted)) m/s (\(item.current.windDir))"
    }
}
