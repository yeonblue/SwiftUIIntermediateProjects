//
//  CodablePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/03.
//

import SwiftUI

struct CodablePractice: View {
    
    @StateObject var viewModel = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            if let customer = viewModel.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text("\(customer.isPremium.description)")
            }
        }
    }
}

struct CodablePractice_Previews: PreviewProvider {
    static var previews: some View {
        CodablePractice()
    }
}

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium = "is_Premium"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.points, forKey: .points)
        try container.encode(self.isPremium, forKey: .isPremium)
    }
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = CustomerModel(id: "1",
                                                            name: "Nick",
                                                            points: 5,
                                                            isPremium: true)
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        print(String(data: data, encoding: .utf8) ?? "")
        
        // let localData = try? JSONSerialization.jsonObject(with: data, options: [])
        // guard let dict = localData as? [String: Any],
        //       let id = dict["id"] as? String,
        //       let name = dict["name"] as? String,
        //       let points = dict["points"] as? Int,
        //       let isPremium = dict["isPremium"] as? Bool else {
        //     return
        // }
        
        // let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
        
        // customer = newCustomer
        
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch {
            print(error)
        }
    }
    
    func getJSONData() -> Data? {
        
        let dict: [String: Any] = [
            "id": "123",
            "name": "James",
            "points": 11,
            "is_Premium": true
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        
        
        let customerModel = CustomerModel(id: "7",
                                          name: "Tim",
                                          points: 3,
                                          isPremium: false)
        let jsonData2 = try? JSONEncoder().encode(customerModel)
        
        return jsonData2
    }
}
