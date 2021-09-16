//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Douglas Henrique de Souza Pereira on 16/09/21.
//

import Foundation

//Data que a view precisa

class WeatherViewModel: ObservableObject{
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=Brasilia&appid=3958457180485a43752e10246420d3ff&lang=pt_br&units=metric"
    
    @Published var title: String = "City"
    @Published var description: String = "-"
    @Published var temp: String = "-"
    @Published var timezone: String = "-"
    @Published var icon: String = ""
    @Published var windSpeed: String = "-"
    @Published var humidity: String = "-"
    @Published var country: String = "Country"
    @Published var sunrise: String = "-"
    @Published var sunset: String = "-"
    
    
    init() {
        self.fetchWeather()
    }
    
    
    func fetchWeather(){
        guard let url = URL(string: baseUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url){ (data, _, error) in
            
            guard let data = data, error == nil else { return }
            
            do{
                let model = try JSONDecoder().decode(WeatherModel.self,
                                                   from: data)
                
                DispatchQueue.main.async {
                    self.title = model.name
                    self.description = model.weather.first?.description ?? "No Description"
                    self.temp = "\(model.main.temp) °C"
                    self.icon = model.weather.first?.icon ?? ""
                    let windSpeedConvert = "\(model.wind.speed*3.6) "
                    let convert = windSpeedConvert.split(separator: ".")[0]
                    self.windSpeed = String("\(convert) km/h")
                    self.humidity = "\(model.main.humidity) %"
                    self.country = model.sys.country
                    
                    let sunriseUnix = TimeInterval(model.sys.sunrise)
                    let sunriseHour = NSDate(timeIntervalSince1970: sunriseUnix)
                    self.sunrise = self.formatHour(sunriseHour: sunriseHour)
                    
                    let sunsetUnix = TimeInterval(model.sys.sunset)
                    let sunsetHour = NSDate(timeIntervalSince1970: sunsetUnix)
                    self.sunset = self.formatHour(sunriseHour: sunsetHour)
                }
            }catch{
                print("Data parse error")
            }
        }
        task.resume()
    }
    
    func formatHour(sunriseHour: NSDate) -> String{
        let hour: String = "\(sunriseHour)"
        let formatedHourSpace = hour.split(separator: " ")[1]
        let formatedHourFinal = formatedHourSpace.split(separator: ":")[0]
        return String(formatedHourFinal)
    }
}
