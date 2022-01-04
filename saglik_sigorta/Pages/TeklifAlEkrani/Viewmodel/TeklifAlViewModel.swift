//
//  TeklifAlViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/30/21.
//
import Foundation
import Alamofire

class TeklifAlViewModel: ObservableObject {
    @Published var age: String = ""
    @Published var hospitalInfo: String = ""

    @Published var offers: [Offer] = []
    @Published var offerIsLoading: Bool = false

    @Published var errorMessage: String = "" {
        didSet {
            if errorMessage.isEmpty {
               showErrorMessage = false
            }
            else {
                showErrorMessage = true
            }
        }
    }
    @Published var showErrorMessage: Bool = false
    
    
    var hasError: Bool {
        return !errorMessage.isEmpty || showErrorMessage
    }
    
    
    var isOfferReady: Bool {
        return !offers.isEmpty && !hasError
    }
     
    
    let validator: FindOfferValidationService = FindOfferValidationService()
    
    func validateInputs() -> (Int, String)? {
        do {
            let age = try validator.validateAge(age)
            let hospitalName = try validator.validateHospitalName(hospitalInfo)
            errorMessage = ""
            return (age, hospitalName)
        }
        catch {
            errorMessage = error.localizedDescription
        }
        return nil
    }
    
    func loadOffer(age: Int, hospitalInfo: String) {
        self.fetchOffer(age: age, hospitalName: hospitalInfo) { [weak self] result in
            DispatchQueue.main.async {
                self?.offerIsLoading = true
                switch result {
                    case .success(let offers):
                        // offer.age = age
                        self?.offers = offers
                    print(offers)
                    case .failure(let error):
                        print(error)
                    self?.errorMessage = error.rawValue
                }
                self?.offerIsLoading = false
            }
            
        }
    }
    
    
    func fetchOffer(age: Int, hospitalName: String, completed: @escaping ApiResultCallback<[Offer], ApiError>) {
        let params: [String: Any] = [
            "age": age,
            "hospitalName": hospitalName
        ]
        
        let urlString = ApiUrls.offer(companyId: 4)
        
        AF
        .request(urlString, method: .post, parameters: params)
        .responseDecodable(of: [Offer].self) { response in
            if response.response?.statusCode == 404 || response.response?.statusCode == 400 {
                completed(.failure(.notFound))
                return
            }
            let result = response.result;
            print(result)
            switch result {
                case .success(let offers):
                    completed(.success(offers))
                case .failure(let error):
                    print(error)
                    completed(.failure(.error))
            }
        }
    }
}
