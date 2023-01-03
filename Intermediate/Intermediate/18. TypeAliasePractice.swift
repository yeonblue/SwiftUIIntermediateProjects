//
//  TypeAliasePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/02.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

struct TVShowModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypeAliasePractice: View {
    
    @State var item: MovieModel = MovieModel(title: "title", director: "sam", count: 5)
    @State var tvShowitem: TVShowModel = TVShowModel(title: "title", director: "sam", count: 5)
    @State var tvitem: TVModel = TVModel(title: "title", director: "sam", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypeAliasePractice_Previews: PreviewProvider {
    static var previews: some View {
        TypeAliasePractice()
    }
}
