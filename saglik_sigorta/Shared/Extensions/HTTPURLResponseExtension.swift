//
//  HTTPURLResponseExtension.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/8/21.
//

import Foundation


extension HTTPURLResponse {
    var isGoodStatusCode: Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
