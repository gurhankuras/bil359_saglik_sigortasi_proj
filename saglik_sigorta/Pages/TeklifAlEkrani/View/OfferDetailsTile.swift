//
//  OfferDetailsTile.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct OfferDetailsTile: View {
    let offer: Offer
    var body: some View {
        HStack {
            CompanyLogo(url: offer.company.image)
            Text("\(offer.company.name)")
                .multilineTextAlignment(.leading)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            /*
            VStack {
                Text("Yaş Aralığı")
                Text(offer.ageRangeText)
            }
             */
           
       
          
            Text(offer.priceStr)
                .font(.body)
                .fontWeight(.semibold)
                //.frame(maxWidth: .infinity)
                .padding(.leading)
                
     
            NavigationLink {
                TeklifSonucDetailsView(offer: offer)
            } label: {
                
                Text("Kabul Et")
                    .lineLimit(1)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.blue)
                
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            .tint(.white)

        }
        
    }
}

struct OfferDetailsTile_Previews: PreviewProvider {
    static var previews: some View {
        OfferDetailsTile(offer: Offer(id: 1, company: Company(id: 2, name: "Axa Sigorta", image: ""), ageStart: 10, ageEnd: 20, amount: 345.50, hospitalId: 1, age: 13)
        
        )
            .preferredColorScheme(.dark)
    }
}
