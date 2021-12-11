//
//  Hospital.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation

struct Hospital: Identifiable, Decodable {
    let id: Int
    let name: String
    let address: Address
    
    private enum CodingKeys : String, CodingKey {
        case id, name="hospital_name", address
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
    
    private enum CodingKeys : String, CodingKey {
        case il, ilce, mahalle, sokak, no="address_no"
    }
}
