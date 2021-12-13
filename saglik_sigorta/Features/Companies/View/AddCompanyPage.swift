//
//  AddCompanyPage.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddCompanyPage: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = AddCompanyViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Şirket Adı")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
            SearchBox(searchText: $vm.name, placeholder: "Giriniz...")
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
                    vm.addCompany()
                    
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
        .alert(vm.infoMessage ?? "", isPresented: $vm.showAlert) {
            Button {
                dismiss()
            } label: {
                Text("Tamam")
            }

        }
        
    }
}

struct AddCompanyPage_Previews: PreviewProvider {
    static var previews: some View {
        AddCompanyPage()
            .preferredColorScheme(.dark)
    }
}
