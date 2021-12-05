//
//  ValidationService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


protocol FindOfferValidationServiceProtocol {
    func validateAge(_ age: String) throws -> Int
    func validateHospitalName(_ name: String) throws -> String
}

struct FindOfferValidationService: FindOfferValidationServiceProtocol {
    
    static let nonSpecialCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")

    enum ValidationError: LocalizedError {
        case invalidAgeRange
        case notNumber
        case invalidHospitalName
        case containsSpecialCharacter
    
        var errorDescription: String? {
            switch self {
            case .invalidAgeRange:
                return "Lütfen geçerli bir sayı giriniz."
            case .notNumber:
                return "Lütfen bir sayı giriniz."
            case .invalidHospitalName:
                return "Lütfen doğru bilgileri girdiğinizden emin olun."
            case .containsSpecialCharacter:
                return "Lütfen doğru bilgileri girdiğinizden emin olun."
            }
        
        }
    }
    
    func validateAge(_ age: String) throws -> Int {
        guard let age = Int(age) else { throw ValidationError.notNumber }
        guard age < 250 else { throw ValidationError.invalidAgeRange }
        return age
    }
    
    func validateHospitalName(_ name: String) throws -> String {
        let processedName = Int(name)
        if processedName != nil { throw ValidationError.invalidHospitalName }
        if name.rangeOfCharacter(from: FindOfferValidationService.nonSpecialCharacters.inverted) != nil {
            throw ValidationError.containsSpecialCharacter
        }

        return name
    }
}
