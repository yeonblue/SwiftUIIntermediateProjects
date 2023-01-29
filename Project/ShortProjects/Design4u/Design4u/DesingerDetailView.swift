//
//  DesingerDetailView.swift
//  Design4u
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI

struct DesingerDetailView: View {
    
    var person: Person
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: person.photo, scale: 3)
                    .overlay {
                        Rectangle()
                            .stroke(.primary, lineWidth: 3)
                    }
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(person.displayName)
                        .font(.largeTitle.bold())
                        .fontDesign(.rounded)
                    Text(person.bio)
                    Text(person.details)
                }
                .padding()
            }
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(person.tags, id: \.self) { tag in
                        Text(tag)
                            .padding(4)
                            .padding(.horizontal)
                            .background(.blue.gradient) // any color에 iOS 16.0에 gradient 추가
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
            })
            .mask({
                LinearGradient(
                    stops: [.init(color: .clear, location: 0),
                            .init(color: .white, location: 0.1),
                            .init(color: .white, location: 0.9),
                            .init(color: .clear, location: 1)],
                    startPoint: .leading,
                    endPoint: .trailing)
            })
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("**Experience:** ^[\(person.experience) years](inflect: true)")
                Text("**Rate** $\(person.rate)")
                Text(.init("**Contact:** \(person.email)")) // URL 링크 양식에 맞게 양식이 바뀜
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .presentationDetents([.medium, .large])
    }
}

struct DesingerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DesingerDetailView(person: .example)
    }
}
