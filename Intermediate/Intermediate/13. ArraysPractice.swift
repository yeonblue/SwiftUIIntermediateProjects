//
//  ArraysPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct ArraysPractice: View {
    
    @StateObject var viewModel = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(viewModel.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.point)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ArraysPractice_Previews: PreviewProvider {
    static var previews: some View {
        ArraysPractice()
    }
}

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [UserModel] = []
    
    init() {
        getUser()
        updateFilteredArray()
    }
    
    func getUser() {
        let user1 = UserModel(name: "Harry", point: 5, isVerified: true)
        let user2 = UserModel(name: "Sam", point: 9, isVerified: true)
        let user3 = UserModel(name: "Joe", point: 2, isVerified: false)
        let user4 = UserModel(name: "Steve", point: 3, isVerified: true)
        let user5 = UserModel(name: "Nick", point: 12, isVerified: true)
        let user6 = UserModel(name: "Lee", point: 4, isVerified: true)
        let user7 = UserModel(name: "Kim", point: 3, isVerified: true)
        let user8 = UserModel(name: "Henry", point: 15, isVerified: false)
        let user9 = UserModel(name: "Chris", point: 0, isVerified: true)
        let user10 = UserModel(name: "Harry", point: 3, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5,
            user6, user7, user8, user9, user10
        ])
    }
    
    func updateFilteredArray() {
        // filteredArray = dataArray.sorted { $0.point > $1.point }
        // filteredArray = dataArray.filter { $0.name.contains("i") }
        filteredArray = dataArray.filter { $0.isVerified }
    }
}
