//
//  SnowView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/24.
//

import SwiftUI

/// CAEmitterLayer는 Core Animation 프레임워크에서 제공하는 레이어 클래스 중 하나로, 입자 효과를 생성하는 레이어.
/// 즉, 입자 시스템(particle system)을 생성하여 다양한 효과를 구현이 가능.
/// 입자 시스템은 입자의 위치, 크기, 속도, 회전 등을 설정하여 다양한 효과를 구현이 가능.

struct SnowView: UIViewRepresentable {
    
    /// 이 메서드는 한 번만 호출되며, 이후에는 UIView가 다시 사용될 때마다 updateUIView(:context:) 메서드가 호출됩니다.
    /// updateUIView(:context:) 메서드는 UIView를 업데이트하고 구성하는 데 사용
    func makeUIView(context: Context) -> some UIView {
        let screen = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height))
        view.layer.masksToBounds = true // 스크린 화면을 벗어나는 것은 자를 것
        
        // configure emitter
        let emitter = CAEmitterLayer()
        emitter.frame = CGRect(x: screen.width / 2, y: -100, width: view.frame.width, height: view.frame.height)
        
        // configure cell
        let cell = CAEmitterCell()
        cell.birthRate = 100 // 뿌려지는 양
        cell.lifetime = 25
        cell.velocity = 160
        cell.scale = 0.035
        cell.emissionRange = .pi
        cell.contents = UIImage(named: "snow")?.cgImage
        
        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

struct SnowView_Previews: PreviewProvider {
    static var previews: some View {
        SnowView()
            .background(.black)
    }
}


/*
 UIViewRepresentable
 
 makeUIView(context:) : UIViewType을 만들고 구성합니다.
 updateUIView(_:context:) : UIViewType을 업데이트하고 구성합니다.
 makeCoordinator() : Coordinator를 만들어 반환합니다.
 dismantleUIView(_:coordinator:) : UIViewType을 해체. SwiftUI 뷰의 수명 주기에서 UIView 객체가 제거될 때 호출. 메모리 해제와 같은 마무리 작업을 수행할 때 사용
 Coordinator : UIViewRepresentable과 UIViewType 간의 통신을 처리하기 위한 Coordinator 객체.
 */
