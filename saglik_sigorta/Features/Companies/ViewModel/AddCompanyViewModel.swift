//
//  AddCompanyViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import Foundation


import Combine
class AddCompanyViewModel: ObservableObject {
    @Published var name = ""
    @Published var infoMessage: String?
    @Published var showAlert = false
    
    
   var cancellables = Set<AnyCancellable>()
   
   init() {
       $showAlert.sink {[weak self] show in
           if !show {
               self?.infoMessage = nil
           }
       }
   }
   
   
   private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
       let (data, response) = output;
       guard let response = response as? HTTPURLResponse,
             response.isGoodStatusCode else {
                 throw URLError(.badServerResponse)
             }
       return data
   }
   
    
    func addCompany() {
        print(ApiUrls.addHospital())
       
        guard let request = makePostRequest(urlStr: ApiUrls.companies(), body: ["name": name]) else {
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
                    print("Bir hata oldu")
                    self?.infoMessage = "Bir hata oldu"
                    self?.showAlert = true
                }
                print("COMPLETION: \(completion)")
                self?.showAlert = true
    
            } receiveValue: {[weak self] msg in
                print(msg.message)
                self?.infoMessage = msg.message
                // self?.showMessage = true
            }
            .store(in: &cancellables)
            
        }
        
        

        private func makePostRequest(urlStr: String, body: [String: Any]) -> URLRequest? {
            guard let url = URL(string: urlStr) else {
                print("Error: cannot create URL")
                return nil
            }
            
            print(body)
            let parameters = body
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
            
            print(request.httpBody)
            // Create the request
            return request
        }
}
