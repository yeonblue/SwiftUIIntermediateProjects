//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/23.
//

import Foundation

/*
 {
   "info": {
     "count": 826,
     "pages": 42,
     "next": "https://rickandmortyapi.com/api/character/?page=2",
     "prev": null
   },
   "results": [
     {
       "id": 1,
       "name": "Rick Sanchez",
       "status": "Alive",
       "species": "Human",
       "type": "",
       "gender": "Male",
       "origin": {
         "name": "Earth",
         "url": "https://rickandmortyapi.com/api/location/1"
       },
       "location": {
         "name": "Earth",
         "url": "https://rickandmortyapi.com/api/location/20"
       },
       "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
       "episode": [
         "https://rickandmortyapi.com/api/episode/1",
         "https://rickandmortyapi.com/api/episode/2",
         // ...
       ],
       "url": "https://rickandmortyapi.com/api/character/1",
       "created": "2017-11-04T18:48:46.250Z"
     },
     // ...
   ]
 }
 */

// MARK: - RMCharacter
struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: String
    let origin: RMSingleLocation
    let location: RMOrigin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - RMSingleLocation
struct RMSingleLocation: Codable {
    let name: String
    let url: String
}

// MARK: - RMOrigin
struct RMOrigin: Codable {
    let name: String
    let url: String
}

// MARK: - RMCharacterStatus
/// The status of the character ('Alive', 'Dead' or 'unknown').
enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - RMCharacterGender
/// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
enum RMCharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}
