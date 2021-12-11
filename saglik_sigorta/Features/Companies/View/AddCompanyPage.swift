//
//  AddCompanyPage.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddCompanyPage: View {
    @Environment(\.dismiss) var dismiss
    @State var companyName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Şirket Adı")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
            SearchBox(searchText: $companyName, placeholder: "Giriniz...")
            Spacer()
            HStack {
                Button {
                    dismiss()
                } label: {
                    
                    Text("İptal")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .red.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                
                Button {
                    dismiss()
                } label: {
                    
                    Text("Ekle")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            .green.opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .tint(.white)
                

            }
        }
        .padding()
        .navigationTitle("Şirketler")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddCompanyPage_Previews: PreviewProvider {
    static var previews: some View {
        AddCompanyPage()
            .preferredColorScheme(.dark)
    }
}
