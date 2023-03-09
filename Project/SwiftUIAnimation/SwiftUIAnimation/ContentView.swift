//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/22.
//

import SwiftUI

struct ContentView: View {
    
    struct Item: Identifiable {
        let id: UUID = UUID()
        let title: String
        let view: AnyView
        
        init<T: View>(title: String, view: T) {
            self.title = title
            self.view = AnyView(view)
        }
    }
    
    let items: [Item] = [
        Item(title: "1. AnimatingCircles", view: AnimatingCircles()),
        Item(title: "2. RecordPlayer", view: RecordPlayer()),
        Item(title: "3. HueRotation", view: HueRotation()),
        Item(title: "4. BreathingFlower", view: BreathingFlower()),
        Item(title: "5. FlyingEagle", view: FlyingEagle()),
        
        Item(title: "6. SpriteAnimation", view: SpriteAnimation()),
        Item(title: "7. HueRotation2", view: HueRotation2()),
        Item(title: "8. PresentDismissTransition", view: PresentDismissTransition()),
        Item(title: "9. ParallaxEffect", view: ParallaxEffect()),
        Item(title: "10. Elevator", view: Elevator()),
        
        Item(title: "11. SwingingGirl", view: SwingingGirl()),
        Item(title: "12. TwinkleStar", view: TwinkleStar()),
        Item(title: "13. Weather", view: Weather()),
        Item(title: "14. GearAndBelts", view: GearAndBelts()),
        Item(title: "15. OceanWaves", view: OceanWaves())
    ]
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    item.view
                } label: {
                    Text(item.title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
