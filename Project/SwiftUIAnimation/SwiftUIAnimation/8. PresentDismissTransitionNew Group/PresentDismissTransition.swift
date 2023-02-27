//
//  PresentDismissTransition.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/27.
//

import SwiftUI

struct PresentDismissTransition: View {
    @State private var isShowing = false
    let gradientBackground = Gradient(colors: [.black, . white, .black])
    let buttonBorderGradient = LinearGradient(gradient: Gradient(colors: [.black, .white, .black]),
                                              startPoint: .leading,
                                              endPoint: .trailing)
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: gradientBackground, startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    Text("Wake Up")
                        .font(.title)
                    Image(systemName: "clock")
                        .font(.largeTitle)
                }.offset(y: -25)
                
                Button {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isShowing = true
                    }
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 20).weight(.bold))
                }
                .padding(10)
                .background(.orange)
                .cornerRadius(20)
                .foregroundColor(.black)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(buttonBorderGradient, lineWidth: 5)
                        .shadow(color: .gray, radius: 5)
                )
                .offset(y: 200)
                
                if isShowing {
                    CustomSettingsView(isShowing: $isShowing)
                        .transition(.fly)
                        .zIndex(1)
                }
            }
        }
    }
}

extension AnyTransition {
    static var fly: AnyTransition {
        get {
            AnyTransition.modifier(active: PresentAndDismiss(offsetValue: 0),
                                   identity: PresentAndDismiss(offsetValue: 1))
        }
    }
}

struct PresentAndDismiss: GeometryEffect {
    
    var offsetValue: Double
    var animatableData: Double {
        get { offsetValue }
        set { offsetValue = newValue }
    }
    
    /// 뷰의 크기가 변경될 때마다 호출. 이 함수는 ProjectionTransform을 반환하는데, 이것은 2D 좌표 공간에서 3D 변환을 적용할 수 있도록 해줌.
    /// Computre Graphics 배울 때, 4x4 matrix 관련 참고
    func effectValue(size: CGSize) -> ProjectionTransform {
        let rotationOffset = offsetValue
        let angleOfRotation = CGFloat(Angle(degrees: 95 * (1 - rotationOffset)).radians)
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1 / max(size.width, size.height)
        
        transform3D = CATransform3DRotate(transform3D, angleOfRotation, 1, 0, 0)
        transform3D = CATransform3DTranslate(transform3D, -size.width/2.0, -size.height/2.0, 0)
        
        let transformAffine1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0,
                                                                     y: size.height / 2.0))
        
        let transformAffine2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(offsetValue * 2),
                                                                     y: CGFloat(offsetValue * 2)))
        if offsetValue <= 0.5 {
            return ProjectionTransform(transform3D).concatenating(transformAffine2).concatenating(transformAffine1)
        } else {
            return ProjectionTransform(transform3D).concatenating(transformAffine1)
        }
    }
}

struct PresentDismissTransition_Previews: PreviewProvider {
    static var previews: some View {
        PresentDismissTransition()
    }
}

/*
 GeometryEffect는 SwiftUI에서 사용되는 기술적 요소로, 뷰의 모양이나 배치에 영향을 주는 역할을 합니다.
 이를 통해 회전, 크기 조정 등의 변환을 적용하여 뷰를 변경하고, 이를 애니메이션화하여 더 생동감있는 인터페이스를 제공할 수 있습니다.
 
 GeometryEffect는 GeometryReader와 함께 사용되며, 주어진 뷰에 대한 변환을 정의합니다.
 이 변환을 적용하면, 뷰의 모양이나 위치 등이 변경되어 더욱 다양한 사용자 인터페이스를 구현할 수 있습니다.

 예를 들어, GeometryEffect를 사용하여 이미지 또는 텍스트를 회전시키거나, 슬라이드되는 애니메이션 효과를 적용할 수 있습니다.
 이러한 변환은 뷰 계층의 일부가 아니라 뷰 레이아웃에 영향을 주는 기술적 요소이므로,
 뷰 계층의 다른 요소와 결합하여 다양한 사용자 인터페이스를 구축하는 데 유용합니다.
 
 Custom Transtion은 뷰간의 전환에 사용
 반면에 GeometryEffect는 뷰 모양이나 배치에 영향을 주는 역할을 합니다.
 이를 사용하여 회전, 크기 조정 등의 변환을 적용하여 뷰를 변경하고, 이를 애니메이션화하여 더 생동감있는 인터페이스를 제공할 수 있습니다.
 */
