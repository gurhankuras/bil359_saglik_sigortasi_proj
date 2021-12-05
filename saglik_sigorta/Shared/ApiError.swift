//
//  ApiError.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/29/21.
//

import Foundation

enum ApiError: String, Error {
    case serverSide = "Server Error"
    case invalidUrl = "Invalid URL"
    case badResponseData = "Corrupt Data"
    // TODO: Later come and fix this based on bad request, response codes etc.
    case error = "Error"
    case notFound = "Bulunamadı"
}
