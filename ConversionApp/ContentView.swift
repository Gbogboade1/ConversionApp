//
//  ContentView.swift
//  ConversionApp
//
//  Created by Ayomide Gbogboade on 31/10/2023.
//

import SwiftUI

enum TemperatureUnits {
 case celsius, kelvin, fahrenheit
}

extension TemperatureUnits{
    var symbol:  String{
        switch self {
        case .celsius: "C"
        case .fahrenheit: "F"
        case .kelvin: "K"
        }
    }
}

struct ContentView: View {
    @State private var fromUnit = TemperatureUnits.celsius
    @State private var toUnit = TemperatureUnits.fahrenheit
    
    @State private var value = 0.0
    
    var toValue: Double{
        if toUnit == fromUnit {
            return value
        }
        

        
        var result: Double = 0.0
          
          switch fromUnit {
          case .celsius:
              switch toUnit {
              case .celsius:
                  result = value
              case .fahrenheit:
                  result = (value * 9/5) + 32
              case .kelvin:
                  result = value + 273.15
              }
              
          case .fahrenheit:
              switch toUnit {
              case .celsius:
                  result = (value - 32) * 5/9
              case .fahrenheit:
                  result = value
              case .kelvin:
                  result = (value - 32) * 5/9 + 273.15
              }
              
          case .kelvin:
              switch toUnit {
              case .celsius:
                  result = value - 273.15
              case .fahrenheit:
                  result = (value - 273.15) * 9/5 + 32
              case .kelvin:
                  result = value
              }
          }
          
          return result
    }
    
    let tempUnits: [TemperatureUnits] = [.celsius, .fahrenheit, .kelvin]
   
    var body: some View {
        NavigationStack{
            Form{
                Section("From"){
                    Picker("Convert from", selection: $fromUnit){
                        ForEach(tempUnits, id: \.self ){
                            Text($0.symbol)
                        }
                    }.pickerStyle(.segmented)
                   
                    
                    TextField("Enter value in ", value: $value, format: .number)
                }
                
               ZStack {
                   Color.blue
                    Section("To"){
                        VStack{
                            Picker("Convert To", selection: $toUnit){
                                ForEach(tempUnits, id: \.self ){
                                    Text($0.symbol)
                                }
                            }.pickerStyle(.segmented)
                            
                            Text(toValue,format: .number)
                        }
                    }
                }

                
                
            }
       
            .navigationTitle("Temprature Converter")
        }
    }
}

#Preview {
    ContentView()
}
