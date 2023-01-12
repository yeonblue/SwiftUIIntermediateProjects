//
//  ViewBuilderPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let descrption: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let descrption = descrption {
                Text(descrption)
                    .font(.callout)
            }
            
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 2)
        }
    }
}

struct HeaderViewGeneric<T: View>: View {
    
    let title: String
    let content: T
    
    init(title: String, @ViewBuilder content: () -> T) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 2)
            
            LocalViewBuilder(type: .one)
        }
    }
}

struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one
        case two
        case three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    
    private var viewTwo: some View {
        Text("Two")
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
    
    // viewOne은 Text, viewThree는 image로 타입이 다르므로 @ViewBuilder를 선언해야 함, return은 미 사용
    @ViewBuilder private var headerSection: some View {
        switch type {
            case .one: viewOne
            case .two: viewTwo
            case .three: viewThree
        }
    }
}

struct ViewBuilderPractice: View {
    var body: some View {
        VStack {
            
            HeaderViewRegular(title: "Title", descrption: "Description", iconName: "heart")
            HeaderViewRegular(title: "Title", descrption: nil, iconName: nil)

            HeaderViewGeneric(title: "ViewBuilder") {
                HStack {
                    Text("Hi")
                    Text("Hi")
                }
            }
            
            CustomHStack {
                Text("custom1")
                Text("custom2")
                Text("custom3")
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ViewBuilderPractice_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderPractice()
    }
}
