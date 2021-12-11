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
    @Published var offer: Offer?
    @Published var offerIsLoading: Bool = false
    
    
    func getOffer(forAge age: Int) {
        
        DispatchQueue.main.async {
            self.offerIsLoading = true
            self.offer = Offer(
                id: 34,
                company: Company(id: 2, name: "Ak Sigorta", image: "sadasd"),
                ageStart: 10,
                ageEnd: 20,
                               amount: 456,
                               hospital:
                                Hospital(id: 4,
                                         name: "Adnan Hastanesi",
                                         address: Address(il: "",
                                                          ilce: "",
                                                          mahalle: "",
                                                          sokak: "",
                                                          no: 12)
                                        )
            )
            self.offerIsLoading = false
        }
    }
    
    let validator: FindOfferValidationService = FindOfferValidationService()
    
    func validateAgeInput() -> Int? {
        do {
            let age = try validator.validateAge(searchText)
            let hospitalName = try validator.validateHospitalName("Yavuz Hastanesi")
            return age
        }
        catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
        return nil
    }
}
