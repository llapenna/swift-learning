//
//  PhoneSheetView.swift
//  Concurrency
//
//  Created by Aerolab on 26/03/2024.
//

import SwiftUI

struct PhoneSheetView: View {
    // INPUTS
    private let onClick: () -> Void
    
    // MISC
    private let phoneCodes: [PhoneCode]
    
    // STATE
    @State private var selectedCode: String
    @State private var phone: String
    
    init(handler onClick: @escaping () -> Void) {
        let list = PhoneSheetView.getPhoneCodes()
        
        self.phoneCodes = list
        self.selectedCode = list[0].dial_code
        self.phone = ""
        
        self.onClick = onClick
    }
    
    var body: some View {
        HStack {
            Picker("Country code", selection: $selectedCode) {
                ForEach(phoneCodes) {
                    Text("(\($0.dial_code)) \($0.flag)").tag($0.dial_code)
                }
            }
            TextField("Phone", text: $phone).textFieldStyle(.roundedBorder)
        }
        Button("Send") {
            onClick()
        }.buttonStyle(.borderedProminent)
    }
    
    
    static private func getPhoneCodes() -> [PhoneCode] {
        guard let path = Bundle.main.path(forResource: "PhoneCodes", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else { return [] }
        
        do {
            return try JSONDecoder().decode([PhoneCode].self, from: data)
        } catch let error {
            print("found error while decoding phone codes!", error)
            return []
        }
    }
}

#Preview {
    PhoneSheetView() { }
}
