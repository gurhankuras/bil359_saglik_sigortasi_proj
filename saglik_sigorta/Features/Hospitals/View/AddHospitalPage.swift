//
//  AddHospitalPage.swift
//  saglik_sigorta
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import SwiftUI

struct AddHospitalPage: View {
    @Environment(\.dismiss) var dismiss
    
    @State var hospitalName = ""
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hastane Adı")
                .font(.title2)
                .bold()
            SearchBox(searchText: $hospitalName, placeholder: "")
                .padding(.bottom, 30)
            Text("Anlaşmalı Şirketler")
                .font(.title2)
                .bold()
            VStack {
                ForEach(0..<5, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 50, height: 50)
                            .padding(.trailing)
                        Text("Axa Sigorta")
                            .frame(maxWidth: .infinity, alignment: .leading)
                   
                        CheckBoxView(checked: $isSelected)
                    }
                    .contentShape(Rectangle())
                    .padding(10)
                    .onTapGesture {
                        isSelected.toggle()
                    }
                    Divider()
                }
            }
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
                }
                .tint(.white)

            }
        

        }
        .padding()
        
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            /*
            .onTapGesture {
                self.checked.toggle()
            }
             */
    }
}

struct AddHospitalPage_Previews: PreviewProvider {
    static var previews: some View {
        AddHospitalPage()
            .preferredColorScheme(.dark)
    }
}
