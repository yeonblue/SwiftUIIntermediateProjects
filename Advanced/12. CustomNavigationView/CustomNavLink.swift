//
//  CustomNavLink.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

// struct NavigationLink<Label, Destination> : View where Label : View, Destination : View
// init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label)

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
                    .toolbar(.hidden)
            }
        } label: {
            label
        }
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink {
                Text("Destination")
            } label: {
                Text("Click Me")
            }
        }
    }
}
