//
//  HospitalView.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/13/21.
//

import SwiftUI


struct HospitalView: View {
    let hospital: Hospital
    
    init(_ hospital: Hospital) {
        self.hospital = hospital
    }
    
    var body: some View {
        HStack() {
            Text(hospital.name)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 100)
          
            HStack {
                VStack {
                    Text("İl:")
                        .font(.subheadline)
                        .padding(.bottom, 2)
                    Text(hospital.address.ilStr)
                        .bold()
                        .lineLimit(1)
                }
                .padding(.horizontal, 4)
                
                VStack {
                    Text("İlçe:").font(.subheadline)
                        .padding(.bottom, 2)
                    Text(hospital.address.ilceStr)
                        .bold()
                        .lineLimit(1)
                }
                .padding(.horizontal, 4)
                
            }
            Spacer()
            NavigationLink(destination: TeklifAlView(), label: {
                TeklifAlButton()
                    .font(.callout)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
            })
            
        }
    
    }
}

struct HospitalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HospitalView(Hospital(id: 2, name: "Yeni Hastane", address: Address(il: nil, ilce: nil, mahalle: nil, sokak: nil, no: nil)))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
            HospitalView(Hospital(id: 2, name: "Yeni Hastane", address: Address(il: "İstanbul", ilce: "Kartal", mahalle: nil, sokak: nil, no: nil)))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
