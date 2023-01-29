//
//  Person.swift
//  Design4u
//
//  Created by yeonBlue on 2023/01/29.
//

import Foundation

struct Person: Comparable, Decodable, Identifiable {
    var id: Int
    var photo: URL
    var thumbnail: URL
    var firstName: String
    var lastName: String
    var email: String
    var experience: Int
    var rate: Int
    var bio: String
    var details: String
    var skills: Set<Skill>
    var tags: [String]
    
    var displayName: String {
        //"\(firstName) \(lastName)"
        let components = PersonNameComponents(givenName: firstName, familyName: lastName)
        return components.formatted() // culture에 따라 알아서 localizd된 양식으로 표시 됨
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    /// sample example for Preview
    static let example = Person(id: 1,
                                photo: URL(string: "https://hws.dev/img/user-1-full.jpg")!,
                                thumbnail: URL(string: "https://hws.dev/img/user-1-thumb.jpg")!,
                                firstName: "Jaime",
                                lastName: "Rove",
                                email: "jrove1@huffingtonpost.com",
                                experience: 10,
                                rate: 300,
                                bio: "I am a graphic designer who specializes in creating unique and eye-catching logos.",
                                details: "My go-to tools are Adobe Illustrator and Photoshop. I love designing anything that can make a strong impact and leave a lasting impression.",
                                skills: [Skill("Illustrator"), Skill("Photoshop")],
                                tags: ["ideator", "aligned", "manager", "excitable"])
}

struct Skill: Comparable, Decodable, Hashable, Identifiable {
   
    var id: String
    
    init(_ id: String) {
        self.id = id
    }
    
    // String으로 올 json을 decode하기 위함
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer() // 단순히 값 하나만 들어온 경우 이를 decode할 수 있다.
        self.id = try container.decode(String.self)
    }
    
    static func <(lhs: Skill, rhs: Skill) -> Bool {
        lhs.id < rhs.id
    }
}
