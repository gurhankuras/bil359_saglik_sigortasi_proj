//
//  AgeBasedOfferViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation


class AgeBasedOfferViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var errorMessage: String = ""
    @Published var showErrorMessage: Bool = false
    
    let validator: FindOfferValidationService = FindOfferValidationService()
    
    func validateAgeInput() -> Void {
        do {
            let age = try validator.validateAge(searchText)
            let hospitalName = try validator.validateHospitalName("Yavuz Hastanesi")
        }
        catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
    }
}
