//
//  DesignerRow.swift
//  Design4u
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI

struct DesignerRow: View {
    
    @ObservedObject var model: DataModel
    @Binding var selectedDesigner: Person?
    
    var person: Person
    var namespace: Namespace.ID
    
    var body: some View {
        HStack {
            Button {
                // select this designer
                guard model.selected.count < 5 else { return }
                withAnimation(.easeInOutBack) {
                    model.select(person)
                }
            } label: {
                HStack {
                    
                    // phase closure를 통해 좀 더 자세한 것들을 handle 가능
                    AsyncImage(url: person.thumbnail, scale: 3)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: person.id, in: namespace)
                    
                    VStack(alignment: .leading) {
                        Text(person.displayName)
                            .font(.headline)
                        Text(person.bio)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .tint(.primary)
            
            Spacer()
            
            Button {
                // show detail
                selectedDesigner = person
            } label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.borderless)
        }
    }
}

struct DesignerRow_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        DesignerRow(model: DataModel(),
                    selectedDesigner: .constant(nil),
                    person: .example,
                    namespace: namespace)
    }
}
