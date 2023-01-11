//
//  GenericPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    func removeInfo() -> BoolModel {
        return BoolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        Text(title)
        content
    }
}

class GenericsViewModel: ObservableObject {
 
    @Published var stringModel = StringModel(info: "Hello, world!")
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Hello, world!!")
    @Published var genericBoolModel = GenericModel(info: false)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}


struct GenericPractice: View {
    
    @StateObject var viewModel = GenericsViewModel()
    
    var body: some View {
        VStack {
            
            GenericView(content: Text("Content!!"),
                        title: "Generic View!")
            
            Text(viewModel.stringModel.info ?? "no data")
            Text(viewModel.boolModel.info?.description ?? "no data")
            
            Text(viewModel.genericStringModel.info ?? "no data")
            Text(viewModel.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            viewModel.removeData()
        }
    }
}

struct GenericPractice_Previews: PreviewProvider {
    static var previews: some View {
        GenericPractice()
    }
}
