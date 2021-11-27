//
//  ErrorView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 11/27/21.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let message: String?
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(systemName: AppSymbols.xmark.rawValue)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.red)
                Text(message ?? "Error")
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color(uiColor: .systemGray6).opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .frame(maxWidth: 300)
    }
}


struct ErrorView_Previews: PreviewProvider {
    static let errorMessage = "Herhangi bir sorun olustu ben de bilmiyorum abi"
    
    static var previews: some View {
        ErrorView(message: errorMessage)
            .preferredColorScheme(.dark)
            .previewDevice("Iphone 11")
            .previewLayout(.sizeThatFits)
    }
}



