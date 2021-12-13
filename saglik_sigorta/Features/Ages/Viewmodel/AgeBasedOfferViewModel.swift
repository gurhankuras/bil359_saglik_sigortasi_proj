//
//  AgeBasedOfferViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation
import Combine

class AgeBasedOfferViewModel: ObservableObject {
    @Published var offers: [CompanyOffersResponse] = []
    @Published var loading = true
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadOffers()
    }
    
    func loadOffers() {
        guard let request = makeGetRequest(urlStr: ApiUrls.offers()) else {
            return
        }
        
        loading = true
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: [String: CompanyOffersResponse].self, decoder: JSONDecoder())
            .map({ cmpMap in
                return cmpMap.map { $1 }
            })
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                    
                }
                print("COMPLETION: \(completion)")
                self?.loading = false
    
            } receiveValue: {[weak self] offers in
                self?.offers = offers
            }
            .store(in: &cancellables)
    }
     
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    

    private func makeGetRequest(urlStr: String) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the request
        return request
    }
    
    
    func deleteCompany(offsets: IndexSet) {
        guard let willDeletedIndex = offsets.first else {
            return;
        }
        
        
        let willDeletedCompany = offers[willDeletedIndex].company
        print(willDeletedCompany)
        
        guard let request = makeDeleteRequest(id: willDeletedCompany.id) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: DemoMessage.self, decoder: JSONDecoder())
            .sink { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("finished")
                    self?.offers.remove(atOffsets: offsets)
                case .failure(let error):
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
            }
            .store(in: &cancellables)
        
    }
    
    
    private func makeDeleteRequest(id: Int) -> URLRequest? {
        guard let url = URL(string: ApiUrls.deleteCompany(id: id)) else {
            print("Error: cannot create URL")
            return nil
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
    /*
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
                               hospitalId: 3
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
     */
}
