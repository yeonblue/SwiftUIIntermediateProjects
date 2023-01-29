//
//  DataModel.swift
//  Design4u
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI

@MainActor // 모든 코드가 MainActor에서 동작할 것을 기대, 반드시 main thread 동작을 의미하지는 않음, main queue에서 동작
class DataModel: ObservableObject {
    
    @Published var people: [Person] = []
    @Published var searchText = ""
    @Published var tokens: [Skill] = []
    @Published private(set) var selected: [Person] = []
    
    var suggestedTokens: Binding<[Skill]> {
        if searchText.starts(with: "#") { // token이 아닌 일반검색과 차별을 두기 위함
            return .constant(allSkills)
        } else {
            return .constant([])
        }
    }
    
    private var allSkills: [Skill] = []
    
    var searchResults: [Person] {
        
        let setTokens = Set(tokens)
        
        return people.filter { person in
            
            // #으로 추가했을 경우(token)
            guard person.skills.isSuperset(of: setTokens) else {
                return false
            }
            
            // 선택한 사람일 경우
            guard selected.contains(person) == false else {
                return false
            }
            
            // 검색단어가 없는 경우 전체 출력
            guard !searchText.isEmpty else {
                return true
            }
            
            // 검색단어 필터링
            for str in [person.firstName, person.lastName, person.bio, person.details] {
                if str.localizedCaseInsensitiveContains(searchText) {
                    return true
                }
            }
            
            return false
        }
    }
    
    func fetch() async throws {
        guard let url = URL(string: "https://hws.dev/designers.json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        people = try JSONDecoder().decode([Person].self, from: data)
        allSkills = Set(people.map(\.skills).joined()).sorted()
    }
    
    func select(_ person: Person) {
        selected.append(person)
    }
    
    func remove(_ person: Person) {
        if let index = selected.firstIndex(of: person) {
            selected.remove(at: index)
        }
    }
}
