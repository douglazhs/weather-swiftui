//
//  Models.swift
//  Weather
//
//  Created by Douglas Henrique de Souza Pereira on 16/09/21.
//

import Foundation

struct WeatherModel: Decodable{
    let weather: [WeatherInfo]
    let main: CurrentWeather
    let wind: WindInfo
    let sys: CountryInfo
    let name: String
}

struct WindInfo: Decodable{
    let speed: Double
}

struct CountryInfo: Decodable{
    let country: String
    let sunrise: Double
    let sunset: Double
}

struct CurrentWeather: Decodable{
    let temp: Float
    let humidity: Int
}

struct WeatherInfo: Decodable {
    let main: String
    let description: String
    let icon: String
}
