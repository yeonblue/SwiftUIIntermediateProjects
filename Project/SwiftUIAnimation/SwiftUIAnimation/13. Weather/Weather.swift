//
//  Weather.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/02.
//

import SwiftUI
import Combine

struct Weather: View {
    
    @State var dataArray = [WeatherDataModel.temperature, WeatherDataModel.precipitation, WeatherDataModel.wind]
    
    @State var capsuleWidth: CGFloat = 30
    @State private var pickerSelection = 0
    @State private var isOn = false
    @State private var animateTemp = false
    @State private var animatePrecip = false
    @State private var animateWind = false
    @State private var animateTempImage = false
    @State private var animatePrecipImage = false
    @State private var animateWindImage = false
    
    init() {
        
        // segmentcontrol 설정 변경
        UISegmentedControl.appearance().selectedSegmentTintColor = .darkGray
        
        // select 했을 때
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // unselect 경우
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        
        ZStack {
            
            Color(red: 255/255, green: 195/255, blue: 0/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: - Title
                Text("Weather")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .shadow(color: .black, radius: 2)
                
                
                // MARK: - Picker
                WeatherPickerView(pickerSelection: $pickerSelection)
                    .onReceive(Just(pickerSelection)) { selectIndex in
                        if selectIndex == 0 {
                            
                            //set the text labels for each segment on the picker
                            animateTemp = true
                            animatePrecip = false
                            animateWind = false
                            
                            //set the images for each segment on the picker
                            animateTempImage = true
                            animatePrecipImage = false
                            animateWindImage = false
                        } else if selectIndex == 1 {
                            
                            //set the text labels for each segment on the picker
                            animatePrecip = true
                            animateTemp = false
                            animateWind = false
                            
                            //set the images for each segment on the picker
                            animateTempImage = false
                            animatePrecipImage = true
                            animateWindImage = false
                        } else if selectIndex == 2 {
                            
                            //set the text labels for each segment on the picker
                            animateWind = true
                            animateTemp = false
                            animatePrecip = false
                            
                            //set the images for each segment on the picker
                            animateTempImage = false
                            animatePrecipImage = false
                            animateWindImage = true
                        }
                    }
                
                // MARK: - Weekly Graph
                ZStack {
                    HStack(spacing: 20) {
                        ForEach(dataArray[pickerSelection]) { data in
                            WeeklyGraph(dayHeightData: data, width: capsuleWidth)
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                        .shadow(color: .black, radius: 8, x: 4, y: 4)
                        .padding(.horizontal, 16)
                }
                .frame(height: 280)
                .animation(.spring(response: 0.9, dampingFraction: 0.6))
                
                GeometryReader { geo in
                    ZStack {
                        ZStack {
                            if animateTemp {
                                Text("Temperature")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .shadow(color: .black, radius: 2)
                                    .transition(.offset(x: 300))
                                    .animation(.easeOut(duration: 1.0))
                            }
                            
                            if animatePrecip {
                                Text("Precipitation")
                                    .fontWeight(.medium)
                                    .font(.title)
                                    .shadow(color: .black, radius: 1, x: 0, y: 2)
                                    .transition(.offset(x: -300))
                                    .animation(.easeOut(duration: 1.0))
                            }
                            
                            if animateWind {
                                Text("Wind")
                                    .fontWeight(.medium)
                                    .font(.title)
                                    .shadow(color: .black, radius: 1, x: 0, y: 2)
                                    .transition(.offset(x: 300))
                                    .animation(.easeOut(duration: 1.0))
                            }
                        }
                        // geometryReader가 차지하는 화면에서 x축 가운데, y축 20% 위치 고정.
                        // position은 superview 좌측 상단 기준
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.2)
                        
                        VStack {
                            if animateTempImage {
                                Image("tempImage").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                                    .position(y: geo.size.height / 2)
                                    .transition(.offset(y: 300))
                                    .animation(Animation.easeOut(duration: 1.0))
                            }
                            
                            if animatePrecipImage {
                                Image("precip").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                                    .position(y: geo.size.height / 2)
                                    .transition(.offset(x: 300))
                                    .animation(.easeOut(duration: 1.0))
                            }
                            
                            if animateWindImage {
                                Image("wind").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                                    .position(y: geo.size.height / 2)
                                    .transition(.offset(x: -300))
                                    .animation(.easeOut(duration: 1.0))
                            }
                        }.position(x: geo.size.width, y: geo.size.height * 0.6)
                    }
                }
            }
        }
    }
}

struct WeeklyGraph: View {
    var dayHeightData: WeatherDataModel
    var width: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .opacity(0.3)
                    .frame(width: width + 2, height: 200)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.black, lineWidth: 2)
                            .shadow(color: .black, radius: 8, x: 0, y: 0)
                    )
                
                Capsule()
                    .frame(width: width, height: dayHeightData.data * 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .opacity(0.9)
                    )
            }
            .padding(.bottom, 8)
            
            Text(dayHeightData.day)
                .font(.system(size: 14))
        }
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        Weather()
    }
}

/*
 background vs overlay
 
 background는 뷰의 배경을 변경하는 데 사용됩니다.
 즉, 뷰의 뒤에 배치되는 콘텐츠를 나타내며, 뷰의 색상, 이미지, 모양 등을 변경할 수 있습니다.
 background는 뷰의 크기를 변경하지 않으며, 뷰가 가장 뒤에 배치되기 때문에 다른 뷰들의 크기와 위치를 변경하지 않습니다.

 overlay는 뷰의 위에 시각적인 요소를 추가하는 데 사용됩니다.
 overlay는 뷰의 크기를 변경하지 않지만, 뷰 위에 콘텐츠를 추가하기 때문에 뷰의 크기가 늘어날 수 있습니다.
 overlay는 뷰의 크기나 위치를 변경하지 않지만, 뷰의 스타일링을 변경하거나 다른 뷰와 겹치는 시각적인 효과를 추가하는 데 사용됩니다.
 */
