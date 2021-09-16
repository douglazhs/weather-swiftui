//
//  View.swift
//  Weather
//
//  Created by Douglas Henrique de Souza Pereira on 16/09/21.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel = WeatherViewModel()
    
    @State private var isLoading = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .center){
                LinearGradient(gradient: Gradient(colors: [chooseGradient(viewModel.icon)[0], chooseGradient(viewModel.icon)[1]]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(alignment: .center){
                    Image(viewModel.icon)
                        .frame(width: 10, height: 150)
                        .padding(.top, 110)
                        .padding(.bottom, 40)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .shadow(radius: 2)
                    
                    Text(viewModel.title)
                        .font(.system(size: 32))
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Text(viewModel.temp)
                        .font(.system(size: 44))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    HStack(alignment: .center){
                        Text(viewModel.description.capitalized)
                            .font(.system(size: 24))
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        
                        Image("umidade")
                            .padding(.trailing, 10)
                            .padding(.leading, 10)
                        
                        Text(viewModel.humidity)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.white))
                    }
                    
                    HStack(alignment: .center){
                        Image("wind")
                            .padding(.trailing, 20)
                        
                        Text(viewModel.windSpeed)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                    }
                    
                    HStack{
                        VStack{
                            Text("Nascer do sol")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemOrange))
                                .padding(.bottom, 5)
                            
                            Text("\(viewModel.sunrise)h")
                                
                        }
                        .padding()
                        
                        VStack{
                            Text("Pôr do sol")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemYellow))
                                .padding(.bottom, 5)
                            
                            Text("\(viewModel.sunset)h")
                        }
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
                if isLoading{
                    LoadingView()
                }
            }
            .navigationTitle("\(viewModel.title), \(viewModel.country)")
            .ignoresSafeArea()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center)
        }
        .onAppear { self.loadScreen()}
    }
    
    func loadScreen(){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
        }
    }
    
    func chooseGradient(_ weather: String) -> [Color]{
        var colors: [Color] = []
        
        switch weather {
        case "01d":
            colors.append(Color(.systemRed))
            colors.append(Color(.systemBlue))
        case "02d":
            colors.append(Color(.systemBlue))
            colors.append(Color(.systemIndigo))
        case "02n":
            colors.append(Color(.systemBlue))
            colors.append(Color(.systemPink))
        case "03d":
            colors.append(Color(.black))
            colors.append(Color(.systemIndigo))
        default:
            colors.append(Color(.black))
            colors.append(Color(.systemBlue))
        }
        return colors
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [chooseGradient("01d")[0], chooseGradient("01d")[1]]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color(.white)))
                .scaleEffect(2)
        }
    }
    
    func chooseGradient(_ weather: String) -> [Color]{
        var colors: [Color] = []
        
        switch weather {
        case "01d":
            colors.append(Color(.systemRed))
            colors.append(Color(.systemBlue))
        case "02d":
            colors.append(Color(.systemBlue))
            colors.append(Color(.systemIndigo))
        case "02n":
            colors.append(Color(.black))
            colors.append(Color(.gray))
        default:
            colors.append(Color(.black))
            colors.append(Color(.systemBlue))
        }
        return colors
    }
}
