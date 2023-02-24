//
//  SpriteAnimation.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/24.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    /// UIKit의 viewDidLoad에 해당
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let ball = SKSpriteNode(imageNamed: "dodgeBall")
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.7)
        ball.physicsBody?.restitution = 0.4 // bounce 관련
        ball.position = location
        addChild(ball)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let ball = SKSpriteNode(imageNamed: "dodgeBall")
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.7)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
}

struct SpriteAnimation: View {
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height)
        return scene
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .white.opacity(0.6)],
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                SpriteView(scene: scene) // iOS 14 추가
                    .frame(width: 320, height: 650)
            }
        }
    }
}

struct SpriteAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SpriteAnimation()
    }
}

/*
 SKScene은 SpriteKit 프레임워크에서 제공하는 클래스로, 2D 게임을 개발할 때 사용.
 SKScene은 화면에 보여질 씬(Scene)을 나타내며, 게임에서 필요한 다양한 객체들을 포함할 수 있다.

 SKScene은 SKNode의 서브클래스이며, 씬 안에 추가되는 모든 노드들은 부모-자식 관계를 형성한다.
 즉, SKScene은 노드들의 계층 구조를 관리하고, 노드들의 위치와 크기를 관리.
 이를 통해 게임에서 다양한 객체들을 쉽게 추가하고 제어할 수 있다.

 SKScene은 다양한 속성과 메서드를 제공한다.
 예를 들어, size 프로퍼티는 씬의 크기를 설정하고, backgroundColor 프로퍼티는 씬의 배경색을 설정.
 또한, didMove(to:) 메서드는 씬이 뷰에 추가되었을 때 호출되는 메서드로, 게임에서 필요한 초기화 작업을 수행할 수 있다.

 SKScene은 게임에서 다양한 객체들을 추가하고 제어할 수 있는 기능을 제공합니다.
 SKSpriteNode를 사용하여 이미지나 텍스처를 표시할 수 있으며, SKLabelNode를 사용하여 텍스트를 표시할 수 있다.
 또한, SKPhysicsBody를 사용하여 객체들 간의 물리적 상호작용을 구현할 수 있다.
 */
