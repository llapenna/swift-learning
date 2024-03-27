//
//  PaywallView.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import SwiftUI

private enum Status: String, Identifiable {
    case phoneRequired
    case otpRequired
    case checkoutCompleted
    case err
    
    var id: String {
        return self.rawValue
    }
}

struct PaywallView: View {
    // STATE
    @State private var sheetStatus: Status? = nil
    @State private var isCompleted = false
    
    var body: some View {
        Group {
            if isCompleted {
                Text("Checkout completed, proceed to download")
                Button("Download") {}
            } else {
                Button("Open phone text field") {
                    openPhoneSheet()
                }
            }
        }.sheet(item: $sheetStatus, onDismiss: checkDismiss) { status in
            Group {
                switch status {
                case .phoneRequired:
                    PhoneSheetView {
                        openOTPSheet()
                    }
                case .otpRequired:
                    OTPSheetView() { result in
                        Task {
                            // This function is async because it must contact the server to check
                            // wether the OTP is correct or not
                            // await verifyOTP()
                            
                            if result {
                                completeCheckout()
                            } else {
                                setError()
                            }
                        }
                    }
                case .checkoutCompleted:
                    Text("completd")
                case .err:
                    Text("Something wrong happened! Try again later")
                }
            }
            .padding()
            .presentationDetents([.fraction(0.25)])
        }
    }
    
    func openPhoneSheet() {
        self.sheetStatus = .phoneRequired
    }
    func openOTPSheet() {
        self.sheetStatus = .otpRequired
    }
    func completeCheckout() {
        self.sheetStatus = .checkoutCompleted
        self.isCompleted = true
    }
    func setError() {
        sheetStatus = .err
    }
    
    func checkDismiss() {
        if self.sheetStatus == nil {
            // Refresh the data for the product
        }
    }
}

//struct PaywallView: View {
//    @State private var sheetStatus: Status? = nil
//    @State private var isCompleted = false
//    
//    var body: some View {
//        Group {
//            if isCompleted {
//                Text("Checkout completed, proceed to download")
//                Button("Download") {}
//            } else {
//                Button("Open phone text field") {
//                    requirePhone()
//                }
//            }
//        }
//        .sheet(item: $sheetStatus) { sheet in
//            Group {
//                switch sheet {
//                case .checkoutCompleted:
//                    Text("Hola!")
//                case .phoneRequired:
//                    PhoneSheetView() {
//                        requireOTP()
//                    }
//                case .otpRequired:
//                    Button("Send OTP to server") {
//                        completeCheckout()
//                    }
//            }
//            .padding()
//            .presentationDetents([.fraction(0.25)])
//        }
//    }
//    
//    func requirePhone() {
//        self.sheetStatus = .phoneRequired
//    }
//    func requireOTP() {
//        self.sheetStatus = .otpRequired
//    }
//    func completeCheckout() {
//        self.sheetStatus = .checkoutCompleted
//    }
//}

#Preview {
    PaywallView()
}
