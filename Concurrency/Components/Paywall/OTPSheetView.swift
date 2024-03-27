//
//  OTPSheetView.swift
//  Concurrency
//
//  Created by Aerolab on 26/03/2024.
//

import SwiftUI

struct OTPSheetView: View {
    static private let OTP_LENGTH = 6
    
    // INPUTS
    private let onClick: (Bool) -> Void
    
    // STATES
    @State private var code = Array(repeating: "", count: OTPSheetView.OTP_LENGTH)
    
    init(handler onClick: @escaping (Bool) -> Void) {
        self.onClick = onClick
    }
    
    var body: some View {
        HStack {
            ForEach(0..<OTPSheetView.OTP_LENGTH, id: \.self) {
                TextField("", text: $code[$0])
                    .textFieldStyle(.roundedBorder)
            }
        }
        Button("Good") {
            onClick(true)
        }
        Button("Bad") {
            onClick(false)
        }
    }
}

#Preview {
    OTPSheetView { result in
        
    }
}
