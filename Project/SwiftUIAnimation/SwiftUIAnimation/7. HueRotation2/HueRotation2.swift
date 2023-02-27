//
//  HueRotation2.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/24.
//

import SwiftUI

struct HueRotation2: View {
    
    @State private var hueRotation = false
    let backgroundImages = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8", "img9", "img10", "img11", "img12", "img13"].shuffled()
    
    var body: some View {
        GeometryReader { geo in
            BackgroundScrollView(imageCount: backgroundImages.count) {
                
                // BackgroundScrollView에는 HStack으로 감싸져 있으므로
                ForEach(0..<backgroundImages.count, id: \.self) { index in
                    Image(backgroundImages[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
            }
            .hueRotation(.degrees(hueRotation ? 0 : 500))
            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: hueRotation)
            .onAppear {
                hueRotation.toggle()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundScrollView<ViewContent: View>: View {
    
    private let imageCount: Int
    private var contentContainer: ViewContent
    
    /// 스크롤 되는 현재 idx
    @State private var workingIndex = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    init(imageCount: Int, @ViewBuilder content: () -> ViewContent) {
        self.imageCount = imageCount
        self.contentContainer = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    contentContainer
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                .offset(x: CGFloat(self.workingIndex) * -geo.size.width) // idx만큼 이동
                .animation(.easeInOut)
                .onReceive(timer) { _ in
                    workingIndex = (workingIndex + 1) % (imageCount == 0 ? 1 : imageCount)
                }
                
                // paging dots
                HStack(spacing: 6) {
                    ForEach(0..<imageCount, id: \.self) { index in
                        Circle()
                            .frame(width: index == workingIndex ? 13: 9,
                                   height: index == workingIndex ? 13: 9)
                            .foregroundColor(index == workingIndex ? .white : .gray)
                            .overlay(Circle().stroke(.black, lineWidth: 1))
                            .padding(.bottom, 20)
                            .animation(.easeInOut)
                    }
                }
            }
        }
    }
}

struct HueRotation2_Previews: PreviewProvider {
    static var previews: some View {
        HueRotation2()
    }
}

/*
 Timer
 
 1.
 on 파라미터에는 타이머 이벤트가 발생할 스레드를 지정하는 값이 들어갈 수 있다.
 보통 .main이나 .global()이 들어감
 
 2.
 in 파라미터에는 타이머가 동작할 실행 루프를 지정하는 값이 들어갈 수 있다.
 보통 .default와 .common이 들어감
 
 .default: 기본 실행 루프에서 타이머 이벤트가 발생하도록 지정합니다.
 기본 실행 루프는 메인 스레드에서 실행됩니다. 이 값은 대부분의 애플리케이션에서 사용되며,
 UI 이벤트 및 애플리케이션의 주요 로직을 처리하는 데 사용됩니다.

 .common: 타이머 이벤트가 발생할 실행 루프를 시스템이 자동으로 선택합니다.
 시스템은 타이머를 실행할 가장 적절한 실행 루프를 선택합니다. 이 값은 일반적으로 우선순위가 중요하지 않은 작업에 사용됩니다.
 예를 들어, 백그라운드에서 동작하는 작업이나 비동기식 작업의 완료 여부를 주기적으로 확인하는 경우에 사용됩니다.

 .default와 .common 중 어떤 값을 사용해야 하는지 결정하는 데는 몇 가지 고려사항이 있습니다.

 .default는 대부분의 경우에 적합합니다.
 UI 이벤트나 애플리케이션의 주요 로직은 대개 메인 스레드에서 실행되기 때문입니다.
 따라서 기본 실행 루프에서 타이머를 실행하는 것이 적절합니다.

 .common은 우선순위가 중요하지 않은 작업에 사용됩니다.
 시스템은 가장 적절한 실행 루프를 선택하여 타이머를 실행합니다. 이는 우선순위가 중요하지 않은 작업의 경우에는 유용합니다.
 하지만 이 값은 실행 루프 선택에 대한 제어를 완전히 시스템에 맡기는 것이므로, 실행 루프에 대한 더 정교한 제어가 필요한 경우에는
 .default 대신 다른 값을 사용해야 할 수도 있습니다.
 */
