//
//  DiscountAccordion.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 1/3/22.
//

import SwiftUI


struct DiscountAccordion: View {
    let discount: [String]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
       ]
    
    @State var isShowing = false
    
    var body: some View {
        VStack {
            HStack {
                //CompanyLogo(url: companyOffer.company.image)
               // Text(companyOffer.company.name)
                //    .bold()
                Spacer()
                Image(systemName: "chevron.down")
            }
            
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                //withAnimation(.easeInOut) {
                    isShowing.toggle()
                //}
            }
            if isShowing {
                VStack {
                    Text("Yaş Grubu Teklifleri")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(discount, id: \.self) { d in
                            HStack {
                                Text("\(d)")
                                    .frame(width: 50, alignment: .leading)
                                Text(":")
                                //Text(String(offer.price))
                                
                            }
                        }
                    }
                }
                .padding()
               
            }
        }
    }
}
