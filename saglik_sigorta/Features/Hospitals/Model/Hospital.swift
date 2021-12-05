//
//  Hospital.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation

struct Hospital: Identifiable, Decodable {
    let id: String
    let name: String
    let address: Address
    
    private enum CodingKeys : String, CodingKey {
        case id="_id", name, address
    }
}

struct Address: Decodable {
    let il: String
    let ilce: String
    let mahalle: String
    let sokak: String
    let no: Int
    
    var string: String {
        return "\(mahalle) \(sokak) \(no) \(ilce) \(il)"
    }
}
