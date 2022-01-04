//
//  NetworkService.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/16/21.
//

import Foundation
import Combine
import Alamofire

protocol NetworkServiceProtocol {
    
    func publisher<T: Decodable>(
            for url: URL,
            responseType: T.Type,
            decoder: JSONDecoder
        ) -> AnyPublisher<T, Error>
    
    func publisher<T: Decodable>(
            for url: URLRequest,
            responseType: T.Type,
            decoder: JSONDecoder
        ) -> AnyPublisher<T, Error>
    
    func makeRequest(urlStr: String, body: [String: Any]?, method: HTTPMethod) -> URLRequest?
}

// https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/

class NetworkService: NetworkServiceProtocol {
    
    
    init() {
        print("NetworkService initiliazed!")
    }

    
    func publisher<T: Decodable>(
            for url: URL,
            responseType: T.Type = T.self,
            decoder: JSONDecoder = .init()
        ) -> AnyPublisher<T, Error> {
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(handleOutput(output:))
                .decode(type: T.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    
    func publisher<T: Decodable>(
            for url: URLRequest,
            responseType: T.Type = T.self,
            decoder: JSONDecoder = .init()
        ) -> AnyPublisher<T, Error> {
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(handleOutput(output:))
                .decode(type: T.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
}

extension NetworkService {
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let (data, response) = output;
        guard let response = response as? HTTPURLResponse,
              response.isGoodStatusCode else {
                  throw URLError(.badServerResponse)
              }
        return data
    }
    
    func makeRequest(urlStr: String, body: [String: Any]?, method: HTTPMethod = .post) -> URLRequest? {
        guard let url = URL(string: urlStr) else {
            print("Error: cannot create URL")
            return nil
        }
        
        guard var request = try? URLRequest(url: url, method: method) else {
            return nil;
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let body = body else {
            return request
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else {
            print("couldn't serialazed")
            return nil
        }
        request.httpBody = serializedBody;
        return request
    }

}

/*
extension URLRequest {
    static
}
 */
