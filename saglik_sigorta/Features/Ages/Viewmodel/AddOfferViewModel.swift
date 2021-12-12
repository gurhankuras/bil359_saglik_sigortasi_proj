//
//  AddOfferViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation
import Combine

class AddOfferViewModel: ObservableObject {
    @Published var companyName = ""
    @Published  var ageStart = ""
    @Published  var ageEnd = ""
    @Published  var price = ""
    @Published var message: String? = nil
    @Published var showMessage: Bool = false
    
    init() {
        $showMessage.sink {[weak self] show in
            if !show {
                self?.message = nil
            }
        }
        .store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func addOffer() {
        guard let request = makeDenemeRequest() else {
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
                    
                case .failure(let error):
                    print(error)
                    print("HATA OLDU")
                }
                print("COMPLETION: \(completion)")
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
                self?.message = msg.message
                self?.showMessage = true
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
    
    private func processInputs() -> [String: Any]? {
        guard let ageStart = Int(ageStart) else {
            return nil
        }
        
        guard let ageEnd = Int(ageEnd) else {
            return nil
        }
        guard let price = Double(price) else {
            return nil
        }
        
        
        return ["name": companyName,
                "ageStart": ageStart,
                "ageEnd": ageEnd,
                "price": price
                ]
    }
    
    private func makeDenemeRequest() -> URLRequest? {
        guard let url = URL(string: ApiUrls.addOffer()) else {
            print("Error: cannot create URL")
            return nil
        }
        
        
        guard let parameters = processInputs() else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        // Create the request
        return request
    }
}
