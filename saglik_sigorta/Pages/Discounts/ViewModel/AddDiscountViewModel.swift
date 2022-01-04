//
//  AddDiscountViewModel.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/3/22.
//

import SwiftUI
import Combine


struct GetOfferResponse: Decodable, Identifiable {
    let price: Double
    let id: Int
}

class AddDiscountViewModel: ObservableObject {
    @Published var companyName: String = ""
    @Published var ageStart: String = ""
    @Published var ageEnd: String = ""
    @Published var discountPercent: String = ""
    @Published var price: Double?
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    
    let networkService: NetworkServiceProtocol
    var constantPrice: Double?
    var id: Int?
    var displayer: MessageDisplayer = MessageDisplayer()
    
    var subscriptions = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        print("init")
        setupSubsriptions()
    }
    
    func setupSubsriptions() {
        Publishers.CombineLatest3(self.$companyName,self.$ageStart, self.$ageEnd)
        .debounce(for: .seconds(0.6), scheduler: RunLoop.main)
            .filter({ (name, start, end) in
                return !name.isEmpty && !start.isEmpty && !end.isEmpty
            })
            .removeDuplicates(by: {$0 == $1})
            .map({ self.loadOffer(name: $0.0, ageStart: Int($0.1)!, ageEnd: Int($0.2)!) })
            .switchToLatest()
            .sink { completion in
                
            } receiveValue: {[weak self] result in
                switch result {
                case .failure(let error):
                    self?.errorMessage = "Teklif Bulunamadı"
                    break
                case .success(let res):
                    self?.errorMessage = ""
                    self?.id = res.id
                    self?.constantPrice = res.price
                    self?.price = res.price
                }
                
                print("girdi")
            }
            .store(in: &subscriptions)
        
        
        $discountPercent
            .removeDuplicates(by: {$0 == $1})
            .map({Int($0)})
            .handleEvents(receiveOutput: { [weak self] percent in
                guard percent != nil else {
                    self?.price = self?.constantPrice
                    return
                }
            })
            .compactMap({ $0 != nil ? abs(min($0!, 100)) : nil })
            .sink { [weak self] percent in
                print("BURADA")
                guard let _ = self?.price, let constPrice = self?.constantPrice else {
                    return
                }
                self?.price = self?.discount(from: constPrice, by: percent)
        }
            .store(in: &subscriptions)
    }
    
    func discount(from price: Double, by percentage: Int) -> Double {
        let percent = Double(100 - percentage) / 100.0
        return percent * Double(price)
    }
    
    func loadOffer(name: String, ageStart: Int, ageEnd: Int) -> AnyPublisher<Result<GetOfferResponse, Error>, Never> {
        let request = networkService.makeRequest(urlStr: "http://localhost:3000/api/getoffer", body: [
            "companyName": name,
            "ageStart": ageStart,
            "ageEnd": ageEnd,
        ], method: .post)
        
        return networkService.publisher(for: request!, responseType: GetOfferResponse.self, decoder: JSONDecoder())
            .map { response in
                return Result.success(response)
            }
            .replaceError(with: .failure(ApiError.notFound))
            .eraseToAnyPublisher()
            
    }
    
    private func addDiscountPublisher(id: Int, price: Double, discountedPrice: Double) -> AnyPublisher<DemoMessage, Error> {
        let request = networkService.makeRequest(urlStr: "http://localhost:3000/api/offers", body: [
            "id": id,
            "currentPrice": price,
            "discountedPrice": discountedPrice
        ], method: .put)
        
        return networkService.publisher(for: request!, responseType: DemoMessage.self, decoder: JSONDecoder())
    }
    
    func addDiscount() {
        guard let _id = id, let _price = price, let _constantPrice = constantPrice,  !discountPercent.isEmpty  else {
            print("sunlardan birisi null: `id` `price` `constantPrice`")
            self.hasError = true
            objectWillChange.send()
            self.displayer.on(message: "Bilgiler eksik")
            return;
        }
        addDiscountPublisher(id: _id, price: _constantPrice, discountedPrice: _price)
            .sink { completion in
                
            } receiveValue: { message in
                print(message)
            }
            .store(in: &subscriptions)

    }
    
  
    
}
