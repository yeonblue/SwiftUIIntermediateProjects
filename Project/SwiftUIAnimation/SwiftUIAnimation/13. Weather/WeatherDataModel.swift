//
//  WeatherDataModel.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/02.
//

import Foundation

struct WeatherDataModel: Identifiable {
    let id = UUID()
    let day: String
    let data: CGFloat
    
    //weekly temperature data
    static let temperature: [WeatherDataModel] = [
       .init(day: "일", data: 0.9),
       .init(day: "월", data: 0.7),
       .init(day: "화", data: 0.9),
       .init(day: "수", data: 0.8),
       .init(day: "목", data: 0.75),
       .init(day: "금", data: 0.65),
       .init(day: "토", data: 0.85)]
   
   //weekly Precipitation data
   static let precipitation: [WeatherDataModel] = [
       .init(day: "일", data: 0.4),
       .init(day: "월", data: 0.6),
       .init(day: "화", data: 0.2),
       .init(day: "수", data: 0.3),
       .init(day: "목", data: 0.4),
       .init(day: "금", data: 0.9),
       .init(day: "토", data: 0.5)]
   
   //weekly wind percentage data
   static let wind: [WeatherDataModel] = [
       .init(day: "일", data: 0.8),
       .init(day: "월", data: 0.4),
       .init(day: "화", data: 0.3),
       .init(day: "수", data: 0.3),
       .init(day: "목", data: 0.5),
       .init(day: "금", data: 0.3),
       .init(day: "토", data: 0.2)]
}
