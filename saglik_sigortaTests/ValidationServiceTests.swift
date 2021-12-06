//
//  ValidationServiceTests.swift
//  saglik_sigortaTests
//
//  Created by Gürhan Kuraş on 11/27/21.
//

@testable import saglik_sigorta
import XCTest

// TODO: refactor copy-pasted code
class ValidationServiceTests: XCTestCase {
    typealias ValidationError = FindOfferValidationService.ValidationError
    
    var validationService:  FindOfferValidationService!
    
    override func setUp() {
        super.setUp()
        validationService = FindOfferValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
        validationService = nil
    }
    
    func test_age_is_valid() throws {

        XCTAssertNoThrow(try validationService.validateAge("10"))
        XCTAssertNoThrow(try validationService.validateAge("1"))
        // I'm aware that this is not reasonable but there is no such a requirement in analysis document
        XCTAssertNoThrow(try validationService.validateAge("-5"))
    }
    
    func test_age_is_not_integer() throws {
        let expectedError =  ValidationError.notNumber
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateAge("abc")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_age_is_in_invalid_range() throws {
        let expectedError =  ValidationError.invalidAgeRange
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateAge("251")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_hospital_name_is_valid() throws {
        XCTAssertNoThrow(try validationService.validateHospitalName("Yavuz Hastanesi"))
    }
    
    func test_hospital_name_is_number() throws {
        let expectedError =  ValidationError.invalidHospitalName
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateHospitalName("45")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_hospital_name_is_empty() throws {
        let expectedError =  ValidationError.invalidHospitalName
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateHospitalName("")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_hospital_name_contains_special_character() throws {
        let expectedError =  ValidationError.containsSpecialCharacter
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.validateHospitalName("Adnan+Hastanesi")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }

}
