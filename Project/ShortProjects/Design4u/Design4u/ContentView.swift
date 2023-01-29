//
//  ContentView.swift
//  Design4u
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI

extension Animation {
    static var easeInOutBack: Animation {
        .timingCurve(0.5, -0.5, 0.5, 1.5)
    }
    
    static func easeInOutBack(duration: TimeInterval = 0.25) -> Animation {
        .timingCurve(0.5, -0.5, 0.5, 1.5, duration: duration)
    }
}

struct ContentView: View {
    
    @StateObject private var model = DataModel()
    @Namespace var namespace // 서로 다른 뷰를 하나로 취급 가능(matchedGeometryReader 이용)
    @State private var selectedDesigner: Person?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // VStack과 달리 최적화 기능 존재. 한번에 전체를 모두 표시하지 않음
                // 또한 VStack과 달리 따로 넓이를 지정하지 않으면 전체 width를 차지
                LazyVStack {
                    ForEach(model.searchResults) { person in
                        DesignerRow(model: model,
                                    selectedDesigner: $selectedDesigner,
                                    person: person,
                                    namespace: namespace)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Design4u")
            .searchable(text: $model.searchText,
                        tokens: $model.tokens,
                        suggestedTokens: model.suggestedTokens,
                        prompt: Text("search, or use a # to select skills")) { token in
                Text(token.id)
            }
            .task {
                do {
                    try await model.fetch()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            .safeAreaInset(edge: .bottom) {
                if model.selected.isEmpty == false {
                    VStack {
                        
                        // selected designers
                        HStack(spacing: -10) {
                            ForEach(model.selected) { person in
                                Button {
                                    withAnimation {
                                        model.remove(person)
                                    }
                                } label: {
                                    AsyncImage(url: person.thumbnail, scale: 3)
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: 3)
                                        )
                                }
                                .buttonStyle(.plain)
                                .matchedGeometryEffect(id: person.id, in: namespace)
                            }
                        }
                        // continue button
                        NavigationLink {
                            
                        } label: {
                            
                            // 1명일때는 person, 2명 이상일 때는 people로 자동으로 변경
                            // InflectionRule(iOS 15 이상 사용 가능) ^[](inflect: true)
                            // 영어, 스페인어 지원 + 4개 국가 지원
                            Text("Select ^[\(model.selected.count) Person](inflect: true)")
                                .frame(maxWidth: .infinity, minHeight: 44) // height는 44 권장
                        }
                        .buttonStyle(.borderedProminent)
                        .contentTransition(.identity) // iOS 16, animation이 조금 달라짐

                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .top])
                    .background(.ultraThinMaterial)
                }
            }
            .sheet(item: $selectedDesigner, content: DesingerDetailView.init)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
